require_relative 'board'
require_relative 'pieces_reference'
require_relative 'board_render'
require_relative 'player'

module Serialize
  attr_reader :board_load, :player1_load, :player2_load

  def save_current(s_name)
    file = File.open("game_saves/#{s_name}", "w")
    serialize_board(file)
    serialize_players(file)
    file.close
  end

  def load_game(s_name)
    unless File.exists?("game_saves/#{s_name}")
      puts "No such save file"
      return
    end
    file = File.readlines("game_saves/#{s_name}")
    deserialize_board(file)
    deserialize_players(file)
    Game.new(player1_load, player2_load, board_load, BoardRender).start_game
  end

  def serialize_players(f_name)
    f_name.puts "#{player1.name}|:#{player1.color}"
    f_name.puts "#{player2.name}|:#{player2.color}"
    f_name.puts current_player.name
  end

  def deserialize_players(f_name)
    @player1_load, @player2_load = nil
    lines = 0
    f_name.each do |line|
      if lines == 64
        data = line.chomp.split("|")
        data[1] = data[1][1..-1].to_sym
        @player1_load = Player.new(data[1], data[0])
      end
      if lines == 65
        data = line.chomp.split("|")
        data[1] = data[1][1..-1].to_sym
        @player2_load = Player.new(data[1], data[0])
      end
      if lines == 66
        @current_player = line.chomp == @player1_load.name ? @player1_load : @player2_load
      end
       lines += 1
    end
  end

  def string_to_class(str)
    case str
    when 'Rook'
      return Rook
    when 'Pawn'
      return Pawn
    when 'King'
      return King
    when 'Bishop'
      return Bishop
    when 'Queen'
      return Queen
    when 'Knight'
      return Knight
    end
  end

  def serialize_board(f_name)
    for i in 0..7
      for j in 0..7
        if board[[i, j]].nil?
          f_name.puts nil
        else
          piece = board[[i, j]]
          f_name.puts "#{piece.class}|#{piece.color}|#{piece.location}"
        end
      end
    end
  end

  def deserialize_board(f_name)
    @board_load = Board.new
    i, j, current_line  = 0, 0, 1

    f_name.each do |line|
      if !line.chomp.empty?
        data = line.chomp.split('|')
        data[0] = string_to_class(data[0])
        data[1] = data[1].to_sym
        data[2] = [data[2][1].to_i, data[2][-2].to_i]
        @board_load[[i, j]] = data[0].new(data[1], @board_load, data[2])
      end
      break if current_line == 64
      current_line += 1
      if j >= 7
        j = 0
        i += 1
        next
      end
      j += 1
    end
  end
end

# To save a game
# First serialize a board, with each piece being saved as its class name, color, board, location
# If its nil write nil on newline, there should be 64 line for board
