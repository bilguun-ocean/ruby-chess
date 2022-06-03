module Slideable
  def available_moves
    moves = []
    move_dirs.each do |d_row, d_col|
      current_move = location
      loop do
        current_move = [current_move[0] + d_row, current_move[1] + d_col]
        # break if out of bounds or hit an enemy piece
        break unless board.in_range?(current_move)

        break if !board.empty?(current_move) && !enemy?(current_move)

        if board.empty?(current_move)
          moves << current_move
        end
        if enemy?(current_move)
          moves << current_move
          break
        end
      end
    end
    moves
  end
end