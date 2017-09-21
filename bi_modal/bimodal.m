clear;
clf;
A1 = [0.5 -1; 1 0.5];
A2 = [1 0.5; 0.5 0.5];
actions = cell(2, 1);
actions{1, 1} = A1; actions{2, 1} = A2;

all_transtions = cell(16, 1);
all_costs = cell(16, 1);

Q = eye(2);
for a = 0:1
    transitionA = actions{a+1, 1};
    costA = Q;
    for b = 0:1
        transitionB = actions{b+1, 1} * transitionA;
        costB = transitionA' * Q * transitionA;
        for c = 0:1
            transitionC = actions{c+1, 1} * transitionB;
            costC = transitionB' * Q * transitionB;
            for d = 0:1
                transitionD = actions{d+1, 1} * transitionC;
                all_transitions{a * 8 + b * 4 + c * 2 + d+1, 1} = ...
                    transitionD;
                costD = transitionC' * Q * transitionC;
                all_costs{a * 8 + b * 4 + c * 2 + d+1, 1} = ...
                    costA + costB + costC + costD;
            end
        end
    end
end


x = -1:0.01:1;
y = -1:0.01:1;
J_xy = zeros(length(x), length(y));
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
                pi_xy(i, j) = func < 8;
                if func < 8
                    bluex = [bluex, x(i)];
                    bluey = [bluey, y(j)];
                else
                    redx = [redx, x(i)];
                    redy = [redy, y(j)];
                end               
                J_xy(i, j) = best_val;
            end
        end
    end
end

surf(x, y, J_xy);
figure;
contour(x, y, J_xy);
figure;

scatter(bluex, bluey, 'b');
hold on; 
scatter(redx, redy, 'r');
