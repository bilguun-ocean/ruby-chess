class BoardRender
  attr_reader :board
  def initialize(board)
    @board = board
  end

  def render
    puts '    0 1 2 3 4 5 6 7'
    (0..7).each do |i|
      puts '   -----------------'
      print "#{i}  |"
      (0..7).each do |j|
        board[[i, j]].nil? ? (print ' |') : (print "#{board[[i, j]]}|")
      end
      print "  #{i}"
      puts ''
    end
    puts '    0 1 2 3 4 5 6 7'
  end

  # add a render for possible move square? using a clone? 
end