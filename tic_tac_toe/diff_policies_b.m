
% Compares the policies from 1a and 1b

pi_diff = pi_win - pi_lose;

for step = 2:2:4
    for board = 0:3^9-1
        [num_x, num_o] = count_pieces(board);
        % Conditions for a board to be reachable
        if and(num_x + num_o == step - 1, num_x == num_o - 1)
            %disp('here')
            if (pi_diff(step, board + 1))
                disp('pos');
                disp(step);
                disp(board);
                disp(pi_win(step, board+1) - board);
                disp(pi_lose(step, board+1) - board);
            end
        end
    end
end