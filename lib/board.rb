require_relative 'pieces_reference'

class Board
  attr_reader :board

  # creates an instance of the board with chess pieces on it
  def self.start_chess
    @board = Board.new
    (0..7).each do |i|
      @board[1, i] = Pawn.new(:black)
      @board[6, i] = Pawn.new(:white)
    end
    [0, 7].each do |i|
      color = (i == 1 ? :black : :white)
      @board[i, 0] = Rook.new(color)
      @board[i, 1] = Knight.new(color)
      @board[i, 2] = Bishop.new(color)
      @board[i, 3] = Queen.new(color)
      @board[i, 4] = King.new(color)
      @board[i, 5] = Bishop.new(color)
      @board[i, 6] = Knight.new(color)
      @board[i, 7] = Rook.new(color)
    end
    @board
  end

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