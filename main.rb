require_relative 'lib/pieces/king'
require_relative 'lib/pieces_reference'
k = King.new(:black)
q = Queen.new(:black)
p = Pawn.new(:white)
b = Bishop.new(:black)
r = Rook.new(:black)
kn = Knight.new(:white)

puts k, q, p, b, r, kn