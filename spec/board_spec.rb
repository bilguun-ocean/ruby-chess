require './lib/pieces_reference'
require './lib/board'
require './lib/board_render'

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
  describe '#move_piece' do 
    it 'can move a piece to a square if its an available_move' do
      b = Board.new
      pawn = b[[6, 3]] = Pawn.new(:black, b, [6, 3])
      BoardRender.new(b).render
      b.move_piece([6, 3], [7, 3])
      expect(b[[7, 3]]).to eql(pawn)
      BoardRender.new(b).render
    end
    it 'can capture an enemy piece if its on an available_move' do 
      b = Board.new
      knight = b[[6, 3]] = Knight.new(:black, b, [6, 3])
      enemy_piece = b[[4, 4]] = King.new(:white, b, [4, 4])
      BoardRender.new(b).render
      b.move_piece([6, 3], [4, 4])
      expect(b[[4, 4]]).to eql(knight)
      BoardRender.new(b).render
    end
    it 'cannot move to a square if an ally is blocking' do 
      b = Board.new
      knight = b[[6, 3]] = Knight.new(:black, b, [6, 3])
      ally_piece = b[[4, 4]] = King.new(:black, b, [4, 4])
      BoardRender.new(b).render
      b.move_piece([6, 3], [4, 4])
      expect(b[[4, 4]]).to eql(ally_piece)
      BoardRender.new(b).render
    end
    it 'cannot move to a square if an ally is blocking' do 
      b = Board.new
      knight = b[[6, 3]] = Knight.new(:black, b, [6, 3])
      ally_piece = b[[4, 4]] = King.new(:black, b, [4, 4])
      BoardRender.new(b).render
      b.move_piece([6, 3], [4, 4])
      expect(b[[4, 4]]).to eql(ally_piece)
      BoardRender.new(b).render
    end
    it 'cannot move to a square if its not an available move for a piece' do 
      b = Board.new
      knight = b[[6, 3]] = Knight.new(:black, b, [6, 3])
      BoardRender.new(b).render
      b.move_piece([6, 3], [2, 2])
      expect(b[[6, 3]]).to eql(knight)
      BoardRender.new(b).render
    end
    it 'empty square cannot be chosen to move' do 
      b = Board.new
      b.move_piece([6, 3], [2, 2])
      b.move_piece([-2, -2], [2, 2])
      expect(b[[2, 2]]).to eql(nil)
      BoardRender.new(b).render
    end
    it 'cannot move out of bounds' do 
      b = Board.new
      knight = b[[6, 3]] = Knight.new(:black, b, [6, 3])
      b.move_piece([6, 3], [-2, -2])
      expect(b[[2, 2]]).to eql(nil)
      BoardRender.new(b).render
    end
  end
end