require_relative 'piece'

class Knight < Piece
  def move_dirs
    [
      [2, 1],
      [1, 2],
      [-1, 2],
      [-2, 1],
      [-2, -1],
      [1, -2],
      [-1, -2],
      [2, -1]
    ]
  end

  def to_s
    color == :black ? '♞' : '♘'
  end
end