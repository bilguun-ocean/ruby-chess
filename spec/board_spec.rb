require './lib/board'

describe Board do
  test_board = Board.new
  describe '#[]' do
    it 'accesses the board with easier syntax. [x,y] instead of [x][y]' do
      expect(test_board[2, 3]).to eql(nil)
    end
    it 'also sets a value on the board' do
      test_board[2, 3] = 'x'
      expect(test_board[2, 3]).to eql('x')
    end
  end
end