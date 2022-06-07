require_relative 'pieces_reference'

class Board
  attr_reader :board

  # creates an instance of the board with chess pieces on it
  def self.start_chess
    board = self.new
    (0..7).each do |i|
      board[[1, i]] = Pawn.new(:black, board, [1, i])
      board[[6, i]] = Pawn.new(:white, board, [6, i])
    end
    [0, 7].each do |i|
      color = (i == 0 ? :black : :white)
      board[[i, 0]] = Rook.new(color, board, [i, 0])
      board[[i, 1]] = Knight.new(color, board, [i, 1])
      board[[i, 2]] = Bishop.new(color, board, [i, 2])
      board[[i, 3]] = Queen.new(color, board, [i, 3])
      board[[i, 4]] = King.new(color, board, [i, 4])
      board[[i, 5]] = Bishop.new(color, board, [i, 5])
      board[[i, 6]] = Knight.new(color, board, [i, 6])
      board[[i, 7]] = Rook.new(color, board, [i, 7])
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


  # returns the pieces that are currently on the board
  def pieces
    pieces = []
    for row in 0..7 
      for col in 0..7
        pieces << self[[row, col]] unless self[[row, col]].nil?
      end
    end
    pieces
  end

  def move_piece(start_pos, end_pos)
    # move_piece should update the piece's internal location!!!!
    # the start_pos could be empty
    if self[start_pos].nil? || !in_range?(start_pos)
      puts "#{start_pos} is an empty square"
      return
    end
    # if the available moves of a start_pos,
    if !self[start_pos].available_moves.include?(end_pos)
      puts "#{end_pos} is not in the available moves"
      return
    end
    self[start_pos], self[end_pos] = nil, self[start_pos]
    # includes end_pos then can move there
  end

  def move_piece!(start_pos, end_pos)
    # also update the internal location!
    self[start_pos], self[end_pos] = nil, self[start_pos]
    self[end_pos].location = end_pos
  end

  def in_check?(color)
    enemy_pieces = pieces.reject { |piece| piece.color == color }
    king_location = pieces
                    .find { |piece| piece.color == color && piece.is_a?(King) }
                    .location
    # the player is in check if current position of the king
    enemy_pieces.each do |piece|
      return true if piece.available_moves.include?(king_location)
    end
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)
    # if all ally piece doesn't have a move that gets the king out of a check
    # then its checkmate
    ally_piece = pieces.select {|piece| piece.color == color }
    ally_piece.all? {|piece| piece.safe_moves.empty? }
  end

  def dup
    new_board = Board.new
    pieces.each do |piece|
      new_piece = piece.class.new(piece.color, new_board, piece.location)
      new_board[new_piece.location] = new_piece
    end
    new_board
  end
end