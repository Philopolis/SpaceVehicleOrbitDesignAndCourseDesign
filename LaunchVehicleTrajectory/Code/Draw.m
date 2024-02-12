%% 绘制图像
function Draw(structCal)
deg = 180/pi;

figure(1)
plot(structCal.t,structCal.v,'black','LineWidth',1.0);
xlabel('{\itt} /s','FontName','Times New Roman','FontSize',10);
ylabel('{\itv} m/s','FontName','Times New Roman','FontSize',10,'Rotation',0);
title('发射坐标系速度-时间曲线','FontSize',10);

figure(2)
plot(structCal.t,structCal.h,'black','LineWidth',1.0);
xlabel('{\itt} /s','FontName','Times New Roman','FontSize',10);
ylabel('{\ith} /m','FontName','Times New Roman','FontSize',10,'Rotation',0);
title('高度-时间曲线');

figure(3)
plot3(structCal.x,structCal.y,structCal.z,'black','LineWidth',2);
xlabel('{\itx} /m','FontName','Times New Roman','FontSize',10);
ylabel('{\ity} /m','FontName','Times New Roman','FontSize',10,'Rotation',0);
zlabel('{\itz} /m','FontName','Times New Roman','FontSize',10);
title('火箭轨迹');
grid on;
 
figure(4)
hold on;
plot(structCal.t,structCal.alpha * deg,'black:','LineWidth',1.0);
plot(structCal.t,structCal.beta * deg,'black--','LineWidth',1.0);
plot(structCal.t,structCal.varphi_pr * deg,'black-','LineWidth',1.0);
plot(structCal.t,structCal.varphi * deg,'black-.','MarkerIndices',1:100:length(structCal.t),'LineWidth',1.0);
plot(structCal.t,structCal.psi * deg,'black-*','MarkerIndices',1:100:length(structCal.t),'LineWidth',1.0);
plot(structCal.t,structCal.theta * deg,'black-o','MarkerIndices',1:100:length(structCal.t),'LineWidth',1.0);
plot(structCal.t,structCal.sigma * deg,'black-x','MarkerIndices',1:100:length(structCal.t),'LineWidth',1.0);
xlabel('{\itt} /s','FontName','Times New Roman','FontSize',10);
ylabel('°','Rotation',0);
title('角度-时间曲线');
legend('攻角','侧滑角','程序角','俯仰角','偏航角','速度倾角','航迹偏角');

figure(5)
hold on;
plot(structCal.t,structCal.delta_varphi * deg,'black','LineWidth',1.0);
plot(structCal.t,structCal.delta_psi * deg,'black:','LineWidth',1.0);
xlabel('{\itt} /s','FontName','Times New Roman','FontSize',10);
ylabel('°','Rotation',0);
title('等效偏转角-时间曲线','FontSize',10);
legend('等效俯仰舵偏角','等效偏航舵偏角');

figure(6)
hold on;
plot(structCal.t,structCal.n_x1,'black','LineWidth',1.0);
plot(structCal.t,structCal.n_y1,'black:','LineWidth',1.0);
plot(structCal.t,structCal.n_z1,'black--','LineWidth',1.0);
xlabel('{\itt} /s','FontName','Times New Roman','FontSize',10);
title('箭体过载-时间曲线','FontSize',10);
legend('轴向过载','法向过载','横向过载');

figure(7)
hold on;
plot(structCal.t,structCal.n_x2,'black','LineWidth',1.0);
plot(structCal.t,structCal.n_y2,'black:','LineWidth',1.0);
plot(structCal.t,structCal.n_z2,'black--','LineWidth',1.0);
xlabel('{\itt} /s','FontName','Times New Roman','FontSize',10);
title('弹道过载-时间曲线','FontSize',10);
legend('切向过载','法向过载','横向过载');
%% 保存数据
% save('v_x.dat','v_x','-ascii');
% save('v_y.dat','v_y','-ascii');
% save('v_z.dat','v_z','-ascii');
% save('x.dat','x','-ascii');
% save('y.dat','y','-ascii');
% save('z.dat','z','-ascii');
% save('alpha.dat','alpha','-ascii');
% save('beta.dat','beta','-ascii');
% save('theta.dat','theta','-ascii');
% save('sigma.dat','sigma','-ascii');
% save('phi.dat','phi','-ascii');
% save('psi.dat','psi','-ascii');
% save('delta_phi.dat','delta_phi','-ascii');
% save('delta_psi.dat','delta_psi','-ascii');
% save('v.dat','v','-ascii');
% save('r.dat','r','-ascii');
% save('R_earth.dat','R','-ascii');
% save('h.dat','h','-ascii');
% save('phi_pr.dat','phi_pr','-ascii');
% save('n_x1.dat','n_x1','-ascii');
% save('n_y1.dat','n_y1','-ascii');
end

