class Piece
  attr_reader :color, :board
  attr_accessor :location

  # available moves that do not allow to move into check.

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


  def safe_moves
    moves = []
    available_moves.each do |move|
      # try the move
      new_board = board.dup
      # if not in check add move to moves
      new_board.move_piece!(location, move)
      if !new_board.in_check?(color)
        moves << move
      end
    end
    moves
  end
end