%% 动力学模型解算
function dot_state = Equations(state,t,Constant,Function)
%% 状态向量提取
v_x = state(1);
v_y = state(2);
v_z = state(3);
x = state(4);
y = state(5);
z = state(6);
%% 常数提取
omega_e = Constant(7,1);
R_origin = Constant(1:3,2);
omega_origin = Constant(1:3,3);
A = Constant(1:3,4:6);
B = Constant(1:3,7:9);
%% 相关变量计算
[inate,~] = IntermediateVariable(state,t,Constant,Function);

% 相关变量提取
m = inate(20,1);
r = inate(9,1);
g_r = inate(18,1);
g_e = inate(19,1);
N_2 = inate(1:3,2);

%% 动力学方程计算
dot_state = state * 0;
dot_state(1:3) = N_2/m + g_r/r * ([x;y;z] + R_origin) + g_e/omega_e * omega_origin - A * ([x;y;z] + R_origin) - B * state(1:3);
dot_state(4:6) = [v_x;v_y;v_z];
end

