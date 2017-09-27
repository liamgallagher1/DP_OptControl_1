clear;
% Evaluates the optimal policy specified in 2.4

K = zeros(2, 4); 

W = zeros(4);
W(1, 1) = 0.1; W(2, 2) = 0.1; % arbitrary noise, 0 Cov

% Solve for J_0_pi with bellman recursion
[P_0, q_0, K_0] = bellman_recursion_optimal(0, 10, W);

x = [0, 0, 1, 1]';
J_actual = x' * P_0 * x + q_0;

% Each linear policy. I repeat work finding them.
Ks = cell(10,1);

for i = 9:-1:0
    [~, ~, K] = bellman_recursion_optimal(i, 10, W);
    Ks{i+1,1} = K;
end

num_tests = 50000;
avg_cost = 0;
for i = 1:num_tests
    random_cost = monte_carlo_evaluation_sequential(x, 0, 10, W, Ks);
    avg_cost = avg_cost + random_cost / num_tests;
end

avg_cost
J_actual
