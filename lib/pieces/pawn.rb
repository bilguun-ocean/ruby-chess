require_relative 'piece'

class Pawn < Piece
  def available_moves
    moves = []
    move_dirs.each do |d_r, d_c|
      current_move = [current_r + d_r, current_c + d_c]
      moves << current_move if board.in_range?(current_move) && (
        board.empty?(current_move)
      )
      # d_left and d_right are different for different colors!
      diagnol_left = [current_r + (color == :black ? 1 : -1), current_c - 1]
      diagnol_right = [current_r + (color == :black ? 1 : -1), current_c + 1]
      moves << diagnol_left if board.in_range?(diagnol_left) && (
        enemy?(diagnol_left)
      )
      moves << diagnol_right if board.in_range?(diagnol_right) && (
        enemy?(diagnol_right)
      )
    end
    moves
  end

  def starting?
    if color == :black
      current_r == 1
    else
      current_r == 6
    end
  end

  def move_dirs
    # if the piece is black direction is 1
    if color == :black
      current_r == 1 ? [[1, 0], [2, 0]] : [[1, 0]]
    # if its white then direction is -1
    else
      current_r == 6 ? [[-1, 0], [-2, 0]] : [[-1, 0]]
    end
  end

  def to_s
    color == :black ? '♟' : '♙'
  end
end