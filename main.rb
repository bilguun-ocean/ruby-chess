require_relative 'lib/pieces/king'
require_relative 'lib/pieces_reference'
require_relative 'lib/board'
require_relative 'lib/board_render'
b = Board.new
rook = b[[0, 0]] = Rook.new(:white, b, [0, 0])
BoardRender.new(b).render
p rook.available_moves

# TODO 
# 1. Write tests for black pawn ✅
# 2. Write tests for rest of the stepable ✅
# 3. Write tests for the slideables
# 4. Make it possible for the piece to move 