require './lib/board'

describe Board do
  test_board = Board.new
  describe '#[]' do
    it 'accesses the board with easier syntax. [x,y] instead of [x][y]' do
      expect(test_board[[2, 3]]).to eql(nil)
    end
    it 'also sets a value on the board' do
      test_board[[2, 3]] = 'x'
      expect(test_board[[2, 3]]).to eql('x')
    end
  end
  describe '#in_range?' do 
    it 'checks whether or not given position is out of the chess board range' do
      expect(test_board.in_range?([8, 0])).to eql(false)
      expect(test_board.in_range?([1, 0])).to eql(true)
    end
  end
end