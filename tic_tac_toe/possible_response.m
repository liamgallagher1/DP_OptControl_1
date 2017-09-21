function new_boards = possible_response(board, is_o)
% Returns a vector of all the boards that the current board could
% transition into after X makes a move. 
new_boards = zeros(1, 9);
size = 0;
response_val = 2;
if is_o
    response_val = 1;
end
for x = 0:2
    for y = 0:2
        prev_val = mod(board, 3^(3*y+x));
        next_val = mod(board, 3^(3*y+x+1)); 
        cells_val = (next_val - prev_val) / 3^(3*y+x);
        if (cells_val == 0)
            new_boards(size+1) = board + response_val * 3^(3*y+x);
            size = size + 1;
        end
    end
end
new_boards = new_boards(1,1:size);
end

