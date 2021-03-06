require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable
  def move_dirs
    # same as bishop and rook combined
    [
      [1, 0],
      [0, 1],
      [-1, 0],
      [0, -1],
      [-1, -1],
      [-1, 1],
      [1, 1],
      [1, -1]
    ]
  end

  def to_s
    color == :black ? '♛' : '♕'
  end
end