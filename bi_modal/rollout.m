clear;
clf;
A1 = [0.5 -1; 1 0.5];
A2 = [1 0.5; 0.5 0.5];
actions = cell(2, 1);
actions{1, 1} = A1; actions{2, 1} = A2;

all_transtions = cell(16, 1);
all_costs = cell(16, 1);

k = 0;

Q = eye(2);
for a = 0:1 %k  = 0
    if k == 0
        transitionA = actions{a+1, 1};
    else
        transitionA = eye(2);
    end
    costA = Q;
    for b = 0:1 % k = 1
        if k <= 1
            transitionB = actions{b+1, 1} * transitionA;
        else
            transitionB = eye(2);
        end
        costB = transitionA' * Q * transitionA;
        for c = 0:1 % k = 2
            if k <= 2
                transitionC = actions{c+1, 1} * transitionB;
            else
                transitionC = eye(2);
            end
            costC = transitionB' * Q * transitionB;
            for d = 0:1 %k = 3
                transitionD = actions{d+1, 1} * transitionC;
                all_transitions{a * 8 + b * 4 + c * 2 + d+1, 1} = ...
                    transitionD; % cost here
                costD = transitionC' * Q * transitionC;
                costE = transitionD' * Q * transitionD;
                all_costs{a * 8 + b * 4 + c * 2 + d+1, 1} = ...
                    costA + costB + costC + costD + costE;
            end
        end
    end
end


x = -1:0.01:1;
y = -1:0.01:1;
J_xy = zeros(length(x), length(y));
C_xy = zeros(length(x), length(y), 3);
pi_xy = zeros(length(x), length(y));

bluex = [];
bluey = [];
redx = [];
redy = [];

for i = 1:length(x)
    for j = 1:length(y)
        best_val = 10^10;
        for func = 1:16
            eval = [x(i), y(j)] * all_costs{func, 1} * [x(i), y(j)]';
            if (eval < best_val)
                best_val = eval;
                val = mod(func, 16) < 8;
                pi_xy(i, j) = val;
                if val
                    bluex = [bluex, x(i)];
                    bluey = [bluey, y(j)];
                    C_xy(i, j, :) = [0, 0, 1];
                else
                    redx = [redx, x(i)];
                    redy = [redy, y(j)];
                    C_xy(i, j, :) = [1, 0, 0];
                end               
                J_xy(i, j) = best_val;
            end
        end
    end
end

% contour(x, y, J_xy);
% figure;
surf(x, y, J_xy, C_xy);
title('Optimal Cost, K = 0, Blue = A1, Red = A2'); 
xlabel('x(1)');
ylabel('x(2)');
figure;
scatter(bluex, bluey, 'b');
hold on; 
scatter(redx, redy, 'r');
title('Optimal Action, K = 0, Blue = A1, Red = A2'); 
xlabel('x(1)');
ylabel('x(2)');
