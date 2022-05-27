require_relative 'piece'

class Bishop < Piece
  def move_dirs
    [
      [-1, -1],
      [-1, 1],
      [1, 1],
      [1, -1]
    ]
  end

  def to_s
    color == :black ? '♝' : '♗'
  end
end