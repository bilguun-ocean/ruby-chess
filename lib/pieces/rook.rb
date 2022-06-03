require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
  include Slideable
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