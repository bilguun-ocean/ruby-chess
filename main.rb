require_relative 'lib/pieces/king'
require_relative 'lib/pieces_reference'
require_relative 'lib/board'
require_relative 'lib/board_render'

b = Board.start_chess

BoardRender.new(b).render