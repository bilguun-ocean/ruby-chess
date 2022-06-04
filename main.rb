require_relative 'lib/pieces/king'
require_relative 'lib/pieces_reference'
require_relative 'lib/board'
require_relative 'lib/board_render'
b = Board.new
b[[6, 3]] = Pawn.new(:black, b, [6, 3])
p b[[6, 3]].available_moves  
b.move_piece([6, 3], [7, 3])
# expect(b[7, 4]).to eql(pawn)
BoardRender.new(b).render
# TODO 
# 1. Write tests for black pawn ✅
# 2. Write tests for rest of the stepable ✅
# 3. Write tests for the slideables  ✅
# 4. Make it possible for the piece to move ✅
# 5. Make a #check?
# 6. Make a #checkmate?
# 7. Make #safe_moves method that 
#   - forces user to not get into check or get out of check
