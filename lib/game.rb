require_relative 'game_save'

class Game
  include Serialize
  attr_reader :player1, :player2, :board, :render, :current_player

  def introduction
    puts <<-Introduction
  Welcome to ruby chess!

    This is a chess implementation on terminal using ruby.
    These are the few functions of this chess:

    - To select a piece and enter a move, you should type in
      2 number combination such as 2 3 which means the square on
      row 2 and column 3.
    - You can save the game on any turn by typing in 'save'
      On your turn to choose a piece. 
    - You can also load the game you have saved when starting
      a new game by simply agreeing and typing in the name of 
      the save file
    - IMPORTANT! When accidentally chosen a piece, you can simply
      type in cancel or c to choose another piece.
    - The stalemate or a draw is decided by the players. 

    So goodluck and have fun! 

  -by bilguun-ocean


    Introduction
  end

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
    render.render
    puts "CHECKMATE!"
  end

  def initialize_game
    introduction
    # ask whether or not to load a game
    puts 'Would you like to load a previous save files ?'
    print 'Y for yes and anything else for no: '
    input = gets.chomp
    if ['y', 'yes'].include?(input.downcase)
      ask_to_load 
      return
    else
      start_game
    end
  end

  # TO DO
  # * Allow user to choose another piece to move ✅
  # * Allow user to save the current game ✅

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
      user_input = gets.chomp
      if ['save', 'Save', 'SAVE'].include?(user_input)
        ask_to_save
        next
      end
      piece_loc = user_input.split.map &:to_i
      next unless piece_loc.is_a?(Array) && piece_loc.all? {|elm| elm.is_a?(Integer) && elm.between?(0, 7)} && piece_loc.length == 2
      if !board.empty?(piece_loc) && board[piece_loc].color == current_player.color
        piece = board[piece_loc]
        puts "Chosen piece #{piece}"
        return piece
      end
      puts 'Invalid piece'
    end
  end

  def ask_to_save
    print "What name would you like to save the current game as? : "
    save_name = gets.chomp
    save_current(save_name)
    puts "The game has been saved as #{save_name} in the game_saves directory."
  end

  def ask_to_load
    print "Enter the name of the save file you would like to load: "
    save_name = gets.chomp
    load_game(save_name)
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