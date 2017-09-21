function [P_k, q_k] = robot_state_val(k, N, W)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Q = [1 0 -1 0; 0 1 0 -1; -1 0 1 0; 0 -1 0 1];

% Base case
if k == N
    P_k = Q;
    q_k = 0;
    return;
end

R = eye(2);
K = zeros(2, 4); 

% Problem 2a specific policy
K(1, :) = [-1 0 1 0]; K(2, :) = [0 -1 0 1];

A = eye(4); 
A(3, :) = [-0.2 0 1.2 0];
A(4, :) = [0 -0.2 0 1.2];
B = zeros(4, 2); B(1, 1) = 1; B(2, 2) = 1;

% Recurse %
[P_next, q_next] = robot_state_val(k + 1, N, W);

% Recursive cost of noise plus expected cost on next step
q_k = q_next + trace(W * P_next);

% local contributor to P_k
local_component = Q + K' * R * K;

% recursive contribution
recursive_component = ...
        A' * P_next * A + ...
        K' * B' * P_next * B * K + ...
        2 * A * P_next * B * K;
    
P_k = local_component + recursive_component;
end

