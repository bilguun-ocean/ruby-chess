require_relative 'lib/pieces/king'
require_relative 'lib/pieces_reference'
require_relative 'lib/board'
require_relative 'lib/board_render'
require_relative 'lib/game'
require_relative 'lib/player'

# TO-DO
# 1. Write tests for black pawn ✅
# 2. Write tests for rest of the stepable ✅
# 3. Write tests for the slideables  ✅
# 4. Make it possible for the piece to move ✅
# 5. Make a #check? ✅
# 6. Make a #checkmate? ✅
# 7. Make #safe_moves method that 
#   - forces user to move out of check or block the check
# x. Make it possible to save a game during each turn 

b = Board.new
king = b[[0, 0]] = King.new(:black, b, [0, 0]) 
b[[3, 0]] = Rook.new(:white, b, [3, 0])
p king.safe_moves