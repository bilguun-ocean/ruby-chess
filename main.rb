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
# 5. Make a #check?
# 6. Make a #checkmate?
# 7. Make #safe_moves method that 
#   - forces user to not get into check or get out of check

game = Game.new(Player.new(:white, 'Jack'), Player.new(:black, 'Sparrow'), Board.start_chess, BoardRender)
game.start_game