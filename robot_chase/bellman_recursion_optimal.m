function [P_k, q_k, K_k] = bellman_recursion_optimal(k, N, W)
% Performs bellman recursion to compute the cost function for a 
% discrete finite time MDP with costs 
% cost: J_k(x) = x' Q x + u' Q u + E[J_k+1(x_k+1)], 
% subject to U = pi_optimal x
% A, B, Q, R hardcoded for problem 2.
% k, N : current and total number of steps.
% W gaussian noise matrix. 
% K: constant linear policy
% Returns P_k, q_k, as J_k(x) = x * P_k * x + q_k

Q = [1 0 -1 0; 0 1 0 -1; -1 0 1 0; 0 -1 0 1];

% Base case
if k == N
    P_k = Q;
    q_k = 0;
    return;
end

R = eye(2);

A = eye(4); 
A(3, :) = [-0.2 0 1.2 0];
A(4, :) = [0 -0.2 0 1.2];
B = zeros(4, 2); B(1, 1) = 1; B(2, 2) = 1;

% Recurse %
[P_next, q_next] = bellman_recursion_optimal(k + 1, N, W);

% Ricatti?
K_k = - inv(B' * P_next * B + R) * B' * P_next * A;

% Recursive cost of noise plus expected cost on next step
q_k = q_next + trace(W * P_next);

% local contributor to P_k
local_component = Q + K_k' * R * K_k;

% recursive contribution
recursive_component = ...
        (A + B * K_k)' * P_next * (A + B * K_k);
    
P_k = local_component + recursive_component;
end

