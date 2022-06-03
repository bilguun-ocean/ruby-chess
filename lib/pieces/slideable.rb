module Slideable
  def available_moves
    moves = []
    move_dirs.each do |d_row, d_col|
      current_move = location
      loop do
        current_move = [current_move[0] + d_row, current_move[1] + d_col]
        # break if out of bounds or hit an enemy piece
        break if !board.in_range?(current_move) || !enemy?(current_move)
        # if hit an enemy piece, add that move and break
        moves << current_move and break if enemy?(current_move)

        # if the move is empty then add to available moves
        moves << current_move
      end
    end
  end
end