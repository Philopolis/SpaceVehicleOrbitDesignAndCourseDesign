%% 程序角函数
function varphi_pr = varphi_program(t)

% 程序角参数
t1 = 10;
t2 = 160;
%t3 = 186.4;
fig = pi/60;

if t < t1
    varphi_pr = pi/2;
elseif t < t2
    varphi_pr = pi/2 + (pi/2 - fig) * ((t - t1)^2/((t2 - t1)^2) - 2 * (t - t1)/(t2 - t1));
else
    varphi_pr = fig;
end
end

