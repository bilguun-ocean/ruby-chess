require './lib/pieces_reference'
require './lib/board'
require './lib/board_render'

describe Piece do
  b = Board.new
  describe '#enemy?' do
    it 'checks if a piece on given location is an enemy' do
      b[[0, 0]] = Pawn.new(:white, b, [0, 0])
      b[[2, 2]] = Pawn.new(:white, b, [2, 2])
      piece = b[[0,0]]
      b[[1, 1]] = Pawn.new(:black, b, [1, 1])
      expect(piece.enemy?([1, 1])).to eql(true)
      expect(piece.enemy?([2, 2])).to eql(false)
      expect(piece.enemy?([5, 5])).to eql(false)
    end
  end

  # Stepping pieces tests
  describe 'King #available_moves' do 
    it 'checks for available moves of king' do
      b = Board.new
      b[[3, 4]] = King.new(:black, b, [3, 4])
      king = b[[3, 4]]
      BoardRender.new(b).render
      expect(king.available_moves.sort).to eql(
        [
        [2, 3], [2, 4], [2, 5],
        [3, 5], [4, 5], [4, 4],
        [4, 3], [3, 3]
        ].sort)
    end
    it "doesn't accept as an available move if ally piece is on it" do
      b[[2, 3]] = Pawn.new(:black, b, [2, 3])
      king = b[[3, 4]]
      BoardRender.new(b).render
      expect(king.available_moves).not_to include([2, 3])
      p king.available_moves
    end
    it "accepts an enemy piece as valid move" do 
      b[[2, 4]] = Pawn.new(:white, b, [2, 4])
      king = b[[3, 4]]
      BoardRender.new(b).render
      expect(king.available_moves).to include([2, 4])
      p king.available_moves
    end
    it "handles corner cases " do 
      b = Board.new
      b[[0, 0]] = King.new(:black, b, [0, 0])
      king = b[[0, 0]]
      BoardRender.new(b).render
      expect(king.available_moves.sort).to eql([[1, 1], [1, 0], [0, 1]].sort)
      p king.available_moves
    end
  end

  describe 'Pawn #available_moves' do
    it 'black pawn can move 2 forward if on the starting line' do
      b = Board.new
      pawn = b[[1, 0]] = Pawn.new(:black, b, [1, 0])
      BoardRender.new(b).render
      expect(p pawn.available_moves).to eql([[2, 0], [3, 0]])
    end
    it 'black pawn can only move 1 step forward if not on the starting line' do
      b = Board.new
      pawn = b[[2, 0]] = Pawn.new(:black, b, [1, 0])
      BoardRender.new(b).render
      expect(p pawn.available_moves).to eql([[3, 0]])
    end
    it 'white pawn can move 2 forward if on the starting line' do
      b = Board.new
      pawn = b[[6, 0]] = Pawn.new(:white, b, [6, 0])
      BoardRender.new(b).render
      expect(p pawn.available_moves).to eql([[5, 0], [4, 0]])
    end
    it 'white pawn can only move 1 step forward if not on the starting line' do
      b = Board.new
      pawn = b[[5, 0]] = Pawn.new(:white, b, [5, 0])
      BoardRender.new(b).render
      expect(p pawn.available_moves).to eql([[4, 0]])
    end
    it 'white cannot move forward if there is an ally blocking upfront' do
      b = Board.new
      pawn = b[[5, 0]] = Pawn.new(:white, b, [5, 0])
      ally_pawn = b[[4, 0]] = Pawn.new(:white, b, [4, 0])
      BoardRender.new(b).render
      expect(p pawn.available_moves).to eql([])
    end
    it 'white cannot move forward if enemy blocking upfront' do 
      b = Board.new
      pawn = b[[5, 0]] = Pawn.new(:white, b, [5, 0])
      enemy_pawn = b[[4, 0]] = Pawn.new(:black, b, [4, 0])
      BoardRender.new(b).render
      expect(p pawn.available_moves).to eql([])
    end
    it 'black cannot move forward if there is an ally blocking upfront' do
      b = Board.new
      pawn = b[[5, 0]] = Pawn.new(:black, b, [5, 0])
      ally_pawn = b[[6, 0]] = Pawn.new(:black, b, [6, 0])
      BoardRender.new(b).render
      expect(p pawn.available_moves).to eql([])
    end
    it 'black cannot move forward if enemy blocking upfront' do 
      b = Board.new
      pawn = b[[5, 0]] = Pawn.new(:black, b, [5, 0])
      enemy_pawn = b[[6, 0]] = Pawn.new(:white, b, [6, 0])
      BoardRender.new(b).render
      expect(p pawn.available_moves).to eql([])
    end
    it 'white can take enemy piece on the up-right' do 
      b = Board.new
      pawn = b[[5, 0]] = Pawn.new(:white, b, [5, 0])
      enemy_pawn = b[[4, 1]] = Pawn.new(:black, b, [4, 1])
      BoardRender.new(b).render
      expect(p pawn.available_moves.sort).to eql([[4, 1], [4, 0]].sort)
    end
    it 'white can take enemy piece on the up-left' do 
      b = Board.new
      pawn = b[[5, 3]] = Pawn.new(:white, b, [5, 3])
      enemy_pawn = b[[4, 2]] = Pawn.new(:black, b, [4, 2])
      BoardRender.new(b).render
      expect(p pawn.available_moves.sort).to eql([[4, 3], [4, 2]].sort)
    end
    it 'black can take enemy piece on the down-right' do 
      b = Board.new
      pawn = b[[5, 0]] = Pawn.new(:black, b, [5, 0])
      enemy_pawn = b[[6, 1]] = Pawn.new(:white, b, [6, 1])
      BoardRender.new(b).render
      expect(p pawn.available_moves.sort).to eql([[6,0], [6, 1]].sort)
    end
    it 'black can take enemy piece on the down-left' do 
      b = Board.new
      pawn = b[[5, 3]] = Pawn.new(:black, b, [5, 3])
      enemy_pawn = b[[6, 2]] = Pawn.new(:white, b, [6, 2])
      BoardRender.new(b).render
      expect(p pawn.available_moves.sort).to eql([[6, 3], [6, 2]].sort)
    end
  end

  describe 'Knight #available moves' do 
    it 'can move to 8 different squares if there is no ally blocking' do
      b = Board.new
      knight = b[[3, 3]] = Knight.new(:white, b, [3, 3])
      BoardRender.new(b).render
      expect(p knight.available_moves.uniq.length).to eql(8)
    end
    it 'cannot move to a square if there is an ally on it' do 
      b = Board.new
      knight = b[[3, 3]] = Knight.new(:white, b, [3, 3])
      ally_piece = b[[1, 4]] = Pawn.new(:white, b, [1, 4])
      BoardRender.new(b).render
      expect(p knight.available_moves.uniq.length).to eql(7)
      p knight.available_moves
    end
    it 'can take enemy piece if its on the available moves' do 
      b = Board.new
      knight = b[[3, 3]] = Knight.new(:white, b, [3, 3])
      ally_piece = b[[1, 4]] = Pawn.new(:black, b, [1, 4])
      BoardRender.new(b).render
      expect(p knight.available_moves.uniq.length).to eql(8)
      p knight.available_moves
    end
    it 'handles corner cases' do
      b = Board.new
      knight = b[[0, 0]] = Knight.new(:white, b, [0, 0])
      BoardRender.new(b).render
      expect(p knight.available_moves.uniq.length).to eql(2)
      p knight.available_moves
    end
  end

  # Sliding piece tests
  describe "Rook #available_moves" do 
    it 'can slide horizontaly and verticaly if no piece is blocking' do 
      b = Board.new
      rook = b[[0, 0]] = Rook.new(:white, b, [0, 0])
      BoardRender.new(b).render
      p rook.available_moves
    end
  end
end
