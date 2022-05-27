class Board
  attr_reader :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def [](row, column)
    @board[row][column]
  end

  def []=(row, column, input)
    @board[row][column] = input
  end
end