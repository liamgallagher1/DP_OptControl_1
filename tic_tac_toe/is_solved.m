function solved = is_solved(board, is_o, first_call)
% Returns true if the board was one by O if is_o, or X, if not is_o
    if nargin == 2
        first_call = true;
    end
    expected_val = 2;
    if (is_o)
        expected_val = 1;
    end
    % Is it solved across? %
    for y = 0:2
        is_solved_r = true;
        for x = 0:2
            prev_val = mod(board, 3^(3*y+x));
            next_val = mod(board, 3^(3*y+x+1)); 
            cells_val = (next_val - prev_val) / 3^(3*y+x);
            is_solved_r = and(is_solved_r, cells_val == expected_val);
        end
        if is_solved_r
            % the opponent cant also win
            solved = true;
            if (first_call)
                solved = not(is_solved(board, not(is_o), false)); 
            end
            return;
        end
    end
    % Is it solved down? %
    for x = 0:2
        is_solved_d = true;
        for y = 0:2
            prev_val = mod(board, 3^(3*y+x));
            next_val = mod(board, 3^(3*y+x+1)); 
            cells_val = (next_val - prev_val) / 3^(3*y+x);
            is_solved_d = and(is_solved_d, cells_val == expected_val);
        end
        if is_solved_d
            solved = true;
            if (first_call)
                solved = not(is_solved(board, not(is_o), false)); 
            end
            return;
        end
    end
    % Is it solved along either cross? %
    is_solved_cross = true;
    for x = 0:2
        prev_val = mod(board, 3^(3*x+x));
        next_val = mod(board, 3^(3*x+x+1)); 
        cells_val = (next_val - prev_val) / 3^(3*x+x);
        is_solved_cross = and(is_solved_cross, cells_val == expected_val);
    end
    if is_solved_cross
        solved = true;
        if (first_call)
            solved = not(is_solved(board, not(is_o), false)); 
        end
        return;
    end
    is_solved_cross = true;
    for x = 0:2
        prev_val = mod(board, 3^(3*x+(2-x)));
        next_val = mod(board, 3^(3*x+(2-x)+1)); 
        cells_val = (next_val - prev_val) / 3^(3*x+(2-x));
        is_solved_cross = and(is_solved_cross, cells_val == expected_val);
    end
    if is_solved_cross
        solved = true;
        if (first_call)
            solved = not(is_solved(board, not(is_o), false)); 
        end
        return;
    end
    solved = false;
end

