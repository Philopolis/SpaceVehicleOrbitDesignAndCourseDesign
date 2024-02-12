%% 其他地理参数计算
function [R_origin,omega_origin,A,B,others] = PositionParameter(B_0,A_0,a_e,b_e,omega_e)

% 起点地面心距、地心经度
phi_0 = atan(b_e^2/a_e^2 * tan(B_0));
mu_0 = B_0 - phi_0;
R_0 = a_e * b_e/sqrt(a_e^2 * sin(phi_0)^2 + b_e^2 * cos(phi_0)^2);
others = [phi_0;mu_0;R_0];

% 起点地面心距向量
R_origin = [-R_0 * sin(mu_0) * cos(A_0);R_0 * cos(mu_0);R_0 * sin(mu_0) * sin(A_0)];

% 起点地球平自转向量
omega_origin = omega_e * [cos(B_0) * cos(A_0);sin(B_0);-cos(B_0) * sin(A_0)];
omega_ex = omega_e * cos(B_0) * cos(A_0);
omega_ey = omega_e * sin(B_0);
omega_ez = omega_e * -cos(B_0) * sin(A_0);

%离心惯性矩阵参数
a_11 = omega_ex^2 - omega_e^2;
a_12 = omega_ex * omega_ey;
a_21 = omega_ex * omega_ey;
a_22 = omega_ey^2 - omega_e^2;
a_23 = omega_ey * omega_ez;
a_32 = omega_ey * omega_ez;
a_33 = omega_ez^2 - omega_e^2;
a_13 = omega_ez * omega_ex;
a_31 = omega_ez * omega_ex;

b_11 = 0;
b_22 = 0;
b_33 = 0;
b_12 = -2 * omega_ez;
b_21 = 2 * omega_ez;
b_31 = -2 * omega_ey;
b_13 = 2 * omega_ey;
b_23 = -2 * omega_ez;
b_32 = 2 * omega_ez;

A = [a_11, a_12, a_13;
     a_21, a_22, a_23;
     a_31, a_32, a_33];

B = [b_11, b_12, b_13;
     b_21, b_22, b_23;
     b_31, b_32, b_33];
end

