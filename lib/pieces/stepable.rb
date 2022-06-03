module Stepable
  # available moves that a stepping piece can make
  def available_moves
    moves = []
    move_dirs.each do |d_r, d_c|
      current_move = [current_r + d_r, current_c + d_c]
      moves << current_move if board.in_range?(current_move) && (
        board.empty?(current_move) || enemy?(current_move)
      )
    end
    moves
  end

end