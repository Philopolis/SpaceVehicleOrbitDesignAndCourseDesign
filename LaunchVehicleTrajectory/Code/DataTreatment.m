%% 数据处理模块
function [structState] = DataTreatment(state_storage,t_storage,Constant,Function)
N = length(t_storage);
Index = 1:N;
% Index = [1:n:N,N]; 数据点间隔n的数组

% 数据处理
structState.t = t_storage;
structState.x = state_storage(4,:);
structState.y = state_storage(5,:);
structState.z = state_storage(6,:);

for i = 1:length(Index)
    [varvec,others] = IntermediateVariable(state_storage(:,Index(i)),t_storage(Index(i)),Constant,Function);
    structState.alpha(i) = varvec(1,1);
    structState.beta(i) = varvec(2,1);
    structState.theta(i) = varvec(3,1);
    structState.sigma(i) = varvec(4,1);
    structState.varphi(i) = varvec(5,1);
    structState.psi(i) = varvec(6,1);
    structState.delta_varphi(i) = varvec(7,1);
    structState.delta_psi(i) = varvec(8,1);
    structState.varphi_pr(i) = others(1,1);
    structState.h(i) = varvec(12,1);
    structState.v(i) = varvec(13,1);
    structState.n_x1(i) = others(1,2);
    structState.n_y1(i) = others(2,2);
    structState.n_z1(i) = others(3,2);
    structState.n_x2(i) = others(1,3);
    structState.n_y2(i) = others(2,3);
    structState.n_z2(i) = others(3,3);
end
end

