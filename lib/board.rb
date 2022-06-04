require_relative 'pieces_reference'

class Board
  attr_reader :board

  # creates an instance of the board with chess pieces on it
  def self.start_chess
    board = self.new
    (0..7).each do |i|
      board[[1, i]] = Pawn.new(:black, board, [1, i])
      board[[6, i]] = Pawn.new(:white, board, [1, i])
    end
    [0, 7].each do |i|
      color = (i == 1 ? :black : :white)
      board[[i, 0]] = Rook.new(color, board, [i, 0])
      board[[i, 1]] = Knight.new(color, board, [i, 0])
      board[[i, 2]] = Bishop.new(color, board, [i, 0])
      board[[i, 3]] = Queen.new(color, board, [i, 0])
      board[[i, 4]] = King.new(color, board, [i, 0])
      board[[i, 5]] = Bishop.new(color, board, [i, 0])
      board[[i, 6]] = Knight.new(color, board, [i, 0])
      board[[i, 7]] = Rook.new(color, board, [i, 0])
    end
    board
  end

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def [](location)
    row, column = location
    @board[row][column]
  end

  def []=(location, input)
    row, column = location
    @board[row][column] = input
  end

  def in_range?(location)
    row, column = location
    row.between?(0, 7) && column.between?(0, 7)
  end

  def empty?(location)
    self[location].nil?
  end

  def move_piece(start_pos, end_pos)
    # the start_pos could be empty
    if self[start_pos].nil? || !in_range?(start_pos)
      puts "#{start_pos} is an empty square"
      return
    end
    # if the available moves of a start_pos,
    if self[start_pos].available_moves.include?(end_pos)
      self[start_pos], self[end_pos] = nil, self[start_pos]
    else
      puts "#{end_pos} is not in the available moves"
    end
    # includes end_pos then can move there
  end
end