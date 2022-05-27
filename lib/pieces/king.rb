require_relative 'piece'

class King < Piece
  def move_dirs
    [
      [-1, 0],
      [-1, 1],
      [0, 1],
      [1, 1],
      [1, 0],
      [1, -1],
      [0, -1],
      [-1, -1]
    ]
  end

  def to_s
    color == :black ? '♚' : '♔'
  end
end