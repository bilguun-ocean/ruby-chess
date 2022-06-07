

class Game
  attr_reader :player1, :player2, :board, :render, :current_player

  def initialize(player1, player2, board, render)
    @player1 = player1
    @player2 = player2
    @board = board
    @render = render.new(@board)
    @current_player = player1
  end

  def switch_player
    @current_player = current_player == player1 ? player2 : player1
  end

  def game_over?
    # change this to later be over when in check_mate
    board.checkmate?(:white) || board.checkmate?(:black)
  end

  def start_game
    # play the game until game_over? is false
    until game_over?
      render.render
      puts "#{current_player.color}'s turn"
      make_turn
      switch_player
    end
    puts "CHECKMATE!"
  end

  # TO DO
  # * Allow user to choose another piece to move ✅
  # * Allow user to save the current game

  # could make this method into smaller method
  def make_turn
    piece, move = nil
    # ask for current player to choose a piece
    loop do 
      piece = choose_piece
      # break if actually a move has been made
      break if move = make_move(piece)
    end
    # execute the move
    board[move] = piece
    board[piece.location] = nil
    piece.location = move
    # change current_player
  end

  def choose_piece
    loop do 
      print 'Choose a piece: '
      piece_loc = gets.chomp.split.map &:to_i
      next unless piece_loc.is_a?(Array) && piece_loc.all? {|elm| elm.is_a?(Integer)} && piece_loc.length == 2
      if !board.empty?(piece_loc) && board[piece_loc].color == current_player.color
        piece = board[piece_loc]
        puts "Chosen piece #{piece}"
        return piece
      end
      puts 'Invalid piece'
    end
  end

  def make_move(piece)
    loop do 
      print 'Choose a move: '
      move = gets.chomp
      return nil if ["cancel", "c", "canc", "Canc", "C", "Cancel"].include?(move)
      move = move.split.map &:to_i
      if piece.available_moves.include?(move)
        return move
      end
      puts 'Invalid move'
      puts "Available moves for this #{piece.to_s} are :#{piece.safe_moves}"
    end
  end

end