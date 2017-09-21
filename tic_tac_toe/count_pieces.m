function [num_x, num_o] = count_pieces(board)
% Returns the number of Xs and Os a board has filled in.
num_x = 0;
num_o = 0;

for y = 0:2
    for x = 0:2
        prev_val = mod(board, 3^(3*y+x));
        next_val = mod(board, 3^(3*y+x+1));
        cells_val = (next_val - prev_val) / 3^(3*y+x);
        if (cells_val == 1)
            num_o = num_o + 1;
        elseif (cells_val == 2)
            num_x = num_x + 1;
        end
    end
end

end

