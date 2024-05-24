class Piece
  attr_accessor :position
  attr_reader :color, :symbol

  def initialize(position, color)
    @position = position
    @color = color
    @symbol = nil
  end

  def valid_moves(board)
    raise NotImplementedError, "This method should be implemented by subclasses"
  end

  def to_s
    @symbol
  end
end