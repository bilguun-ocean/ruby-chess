class BoardRender
  attr_reader :board
  def initialize(board)
    @board = board
  end

  def render
    (0..7).each do |i|
      puts '----------------'
      (0..7).each do |j|
        board[[i, j]].nil? ? (print ' |') : (print "#{board[[i, j]]}|")
      end
      puts ''
    end
  end

  # add a render for possible move square? using a clone? 
end