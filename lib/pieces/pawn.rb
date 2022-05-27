require_relative 'piece'

class Pawn < Piece
  def move_dirs
    [
      # Remember to somehow make Pawn move 2 forward when on starting line
      [1, 0]
    ]
  end

  def to_s
    color == :black ? '♟' : '♙'
  end
end