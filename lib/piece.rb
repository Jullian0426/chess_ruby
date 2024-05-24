class Piece
  attr_reader :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
    @symbol = nil
  end

  def symbol
    @symbol
  end

  def valid_moves(board)
    []
  end
end