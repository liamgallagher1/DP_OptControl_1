function J_x_achieved = monte_carlo_evaluation(x, k, N, W, K)
% Performs bellman recursion to compute the cost function for a 
% discrete finite time MDP with costs 
% cost: J_k(x) = x' Q x + u' Q u + E[J_k+1(x_k+1)], 
% subject to U = K x
% A, B, Q, R hardcoded for problem 2.
% k, N : current and total number of steps.
% W gaussian noise matrix. 
% K: constant linear policy
% Returns P_k, q_k, as J_k(x) = x * P_k * x + q_k

Q = [1 0 -1 0; 0 1 0 -1; -1 0 1 0; 0 -1 0 1];
% Base case
if k == N
    J_x_achieved = x' * Q * x;
    return;
end

% Hard code some matrices
R = eye(2);
A = eye(4); 
A(3, :) = [-0.2 0 1.2 0];
A(4, :) = [0 -0.2 0 1.2];
B = zeros(4, 2); B(1, 1) = 1; B(2, 2) = 1;

% Fixed linear policy
u = K * x;
% Gaussian noise
omega = mvnrnd(zeros(4, 1), W, 1);
% State transition
x_next = A * x + B * u + omega';

% Recurse %
J_x_next = monte_carlo_evaluation(x_next, k + 1, N, W, K);
% Cost of state and action
local_cost = x' * Q * x + u' * R * u;

J_x_achieved = local_cost + J_x_next;
end

