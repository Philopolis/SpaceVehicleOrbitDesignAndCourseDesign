%% main func
close all; clear; clc;
format compact; format long;
%% 预处理
% 时间与步长
t0 = 0;
t_end = 186.4;
step = 0.1;

% 常数向量

% 气动参数
S_M = pi/4 * 1.67^2; % 箭体最大横截面积
C_x = 0.2; % 阻力系数
C_y_alpha = 2;

% 地理参数
p_0 = 101325;
a_e = 6378145;
b_e = a_e * (1 - 1/298.257);
omega_e = 7.292115 * 10^(-5);
% 发射点纬度与发射方位角
B_0 = 0.715; % 酒泉卫星发射中心地理纬度
A_0 = 0;

[R_origin,omega_origin,A,B,others] = PositionParameter(B_0,A_0,a_e,b_e,omega_e);

% 引力参数
fM = 3.986005 * 10^14;
J = 3/2 * 1.08263 * 10^(-3);

% 控制参数
A_varphi = 3;
k_varphi = 1;
a_0_varphi = 1;
u_varphi = 0;

A_psi = 1.2;
k_psi = 1;
a_0_psi = 1;
u_psi = 0;

Constant(:,1) = [S_M;C_x;C_y_alpha;p_0;a_e;b_e;omega_e;B_0;A_0;fM;J;A_varphi;k_varphi;a_0_varphi;u_varphi;A_psi;k_psi;a_0_psi;u_psi];
Constant(1:3,2) = R_origin;
Constant(1:3,3) = omega_origin;
Constant(1:3,4:6) = A;
Constant(1:3,7:9) = B;
Constant(1:3,10) = others;

% 大气模型
load('Atmos.mat');
AtmosFbox.p = Atmos_PressureAltitude_pchip;
AtmosFbox.rho = Atmos_DensityAltitude_pchip;

% 初始状态量
state0 = [zeros(6,1)];

% 初始化储存数组
state_storage = zeros(6,(t_end - t0)/step + 1);
t_storage = zeros(1,(t_end - t0)/step + 1);

% 赋初值
i = 1;
state_storage(:,i) = state0;
t_storage(i) = t0;
%% 迭代循环计算
while(1)
    % 递推
    [state1,t1] = RK4(state0,t0,step,Constant,AtmosFbox);

    % 检查程序
    if(sum(isnan(state1)))
        disp('程序出错，检查代码')
        break;
    end

    % 仿真终止判断
    if t1 > t_end + step/2
        break;
    else
        % 迭代赋值
        state0 = state1;
        t0 = t1;
        i = i + 1;

        % 记录数据
        state_storage(:,i) = state0;
        t_storage(i) = t0;
    end
end

% 清楚多余存储空间
state_storage(:,i+1:end) = [];
t_storage(i+1:end) = [];
%% 数据处理与绘图
[structCal] = DataTreatment(state_storage,t_storage,Constant,AtmosFbox);
Draw(structCal);

