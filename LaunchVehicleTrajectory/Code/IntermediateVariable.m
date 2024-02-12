%% 相关量计算
function [varvec,others] = IntermediateVariable(state,t,Constant,Function)
%% 状态量提取
v_x = state(1);
v_y = state(2);
v_z = state(3);
x = state(4);
y = state(5);
z = state(6);
%% 质量计算
m = mass(t);
%% 程序角计算
varphi_pr = varphi_program(t);
%% 速度倾角计算
if v_x == 0
    theta = pi/2;
else
    theta = atan(v_y/v_x);
end
%% 速率计算
v = sqrt(v_x^2 + v_y^2 + v_z^2);
%% 航迹偏角计算
if v == 0
    sigma = 0;
else
    sigma = -asin(v_z/v);
end
%% 攻角计算
% 常数提取
A_varphi = Constant(12,1);
omega_ez = Constant(3,3);
k_varphi = Constant(13,1);
a_0_varphi = Constant(14,1);
u_varphi = Constant(15,1);
alpha = A_varphi * ((varphi_pr - omega_ez * t - theta) - k_varphi/a_0_varphi * u_varphi);
%% 俯仰角计算
varphi = theta + alpha;
%% 侧滑角计算
% 常数提取
A_psi = Constant(16,1);
omega_ex = Constant(1,3);
omega_ey = Constant(2,3);
k_psi = Constant(17,1);
a_0_psi = Constant(18,1);
u_psi = Constant(19,1);
beta = A_psi * ((omega_ex * sin(varphi) - omega_ey * cos(varphi)) * t - sigma - k_psi/a_0_psi * u_psi);
%% 偏航角计算
psi = sigma + beta;
%% 等效俯仰舵偏角计算
delta_varphi = a_0_varphi * (varphi + omega_ez * t - varphi_pr) + k_varphi * u_varphi;
%% 等效偏航舵偏角计算
delta_psi = a_0_psi * (psi + (omega_ey * cos(varphi) - omega_ex * sin(varphi) * t)) + k_psi * u_psi;
%% 地心距计算
% 常数提取
R_0x = Constant(1,2);
R_0y = Constant(2,2);
R_0z = Constant(3,2);
r = sqrt((x + R_0x)^2 + (y + R_0y)^2 + (z + R_0z)^2);
%% 星下点地心经度计算
% 常数提取
omega_e = Constant(7,1);
sinphi = ((x + R_0x) * omega_ex + (y + R_0y) * omega_ey + (z + R_0z) * omega_ez)/(r * omega_e);
%% 星下点地心距计算
% 常数提取
a_e = Constant(5,1);
b_e = Constant(6,1);
R = a_e * b_e/sqrt(a_e^2 * sinphi^2 + b_e^2 * (1 - sinphi^2));
%% 高度计算
h = r - R;
%% 推力计算
% 常数提取
p_0 = Constant(4,1);
S_M = Constant(1,1);
% 函数提取
p_H = Function.p;
P = Propulsion(t) + S_M * (p_0 - p_H(h));
%% 气动力计算
% 常数提取
C_x = Constant(2,1);
C_y_alpha = Constant(3,1);
% 函数提取
rho = Function.rho;
X = C_x * 1/2 * rho(h) * v^2 * S_M;
Y = C_y_alpha * 1/2 * rho(h) * v^2 * S_M * alpha;
Z = -C_y_alpha * 1/2 * rho(h) * v^2 * S_M * beta;
%% 引力加速度计算
% 常数提取
fM = Constant(10,1);
J = Constant(11,1);
g_r = -fM/(r^2) * (1 + J * (a_e/r)^2 * (1 - 5 * sinphi^2));
g_e = -2 * fM/(r^2) * J * (a_e/r)^2 * sinphi;
%% 转换矩阵计算
G_B = [cos(varphi) * cos(psi), -sin(varphi), cos(varphi) * sin(psi);
       sin(varphi) * cos(psi),  cos(varphi), sin(varphi) * sin(psi);
                    -sin(psi),            0,               cos(psi)];
G_V = [cos(theta) * cos(sigma), -sin(theta), cos(theta) * sin(sigma);
       sin(theta) * cos(sigma),  cos(theta), sin(theta) * sin(sigma);
                   -sin(sigma),           0,              cos(sigma)];
%% 过载计算
% 箭体过载
B_V = G_B^(-1) * G_V;
g_local = abs(-fM/(R^2) * (1 + J * (a_e/R)^2 * (1 - 5 * sinphi^2)));
N_1(:,1) = [P;0;0] + B_V * [-X;Y;Z];
n_1 = N_1/(m * g_local);

% 弹道过载
N_2(:,1) = G_B * [P;0;0] + G_V * [-X;Y;Z];
n_2 = N_2/(m * g_local);
%% 相关量汇总
varvec(:,1) = [alpha;beta;theta;sigma;varphi;psi;delta_varphi;delta_psi;r;sinphi;R;h;v;P;X;Y;Z;g_r;g_e;m];
varvec(1:3,2) = N_2;
others(:,1) = varphi_pr;
others(1:3,2) = n_1;
others(1:3,3) = n_2;
end

