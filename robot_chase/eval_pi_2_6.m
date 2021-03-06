clear;
% Evaluates the deterministic policy specified in 2.2

N = 10;

costs = zeros(1, 500);

for N = 1:500
    K = zeros(2, 4);
    % Problem 2a specific policy
    K(1, :) = [-1 0 1 0]; K(2, :) = [0 -1 0 1];
    
    W = zeros(4);
    W(1, 1) = 0.1; W(2, 2) = 0.1; % arbitrary noise, 0 Cov
    
    % Solve for J_0_pi with bellman recursion
    [P_0, q_0] = bellman_recursion_const(0, N, W, K);
    
    x = [0, 0, 1, 1]';
    J_actual = x' * P_0 * x + q_0;
    costs(N) = J_actual / N;
end

plot(1:500, costs);
title('Infinite Horizon Convergence');
xlabel('Horizon');
ylabel('Average cost per step');


