require_relative 'piece'

class Rook < Piece
  def move_dirs
    [
      [1, 0],
      [0, 1],
      [-1, 0],
      [0, -1]
    ]
  end

  def to_s
    color == :black ? '♜' : '♖'
  end
end