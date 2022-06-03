class Piece
  attr_reader :color, :board, :location

  def initialize(color, board, location)
    @color = color
    @board = board
    @location = location
  end

  def current_r
    location[0]
  end

  def current_c
    location[1]
  end

  def enemy?(location)
    return false if board[location].nil?
    board[location].color != color
  end
end