clear;
% Tic_tac_toe board states are represented as ints in [0, 3^9)
% numbered from top left to bottom right as increasing powers of 3, 
% empty is 0, an O is 1, and an X is 2. 

J_x = zeros(10, 3^9); % Value of being in a board state at the start of a move 

pi = zeros(9, 3^9);

% Solve for terminal board states
for board = 0:3^9 - 1
    if is_solved(board, false) % Did X win this board?
        J_x(10, board+1) = 1;
    end
end

% For all other non terminal moves
for step = 8:-2:2
    for board = 0:3^9 - 1
        % Again, Did I already win?
        if is_solved(board, false)
            J_x(step, board+1) = 1;
            continue;
        end
        % I can make these moves
        my_responses = possible_response(board, false); % X moves
        num_responses = length(my_responses);
        board_val = 0;
        for i = 1:num_responses
            next_board = my_responses(i);
            if is_solved(next_board, false)
                board_val = 1;
                pi(step, board+1) = next_board;
                break;
            end
            % But my oponnent is equally likely to respond with these
            opponent_responses = possible_response(next_board, true); % O responds
            move_val = 0; 
            for j = 1:length(opponent_responses)
                % Average value over all the subsequent oponent responses
                scenario_val = J_x(step+2, opponent_responses(j)+1); 
                move_val = move_val + scenario_val / length(opponent_responses);
            end
            if (move_val > board_val)
                board_val = move_val;
                pi(step, board+1) = next_board;
            end
        end
        J_x(step, board+1) = board_val;
    end
end

prob = 0;
for i = 0:8
    prob = prob + J_x(2, 3^i + 1) / 9;
end
prob