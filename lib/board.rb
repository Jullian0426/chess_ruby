# lib/board.rb
class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def place_piece(piece, pos)
    row, col = pos
    piece.position = pos
    @grid[row][col] = piece
  end

  def get_piece(pos)
    row, col = pos
    @grid[row][col]
  end

  def move_piece(start_pos, end_pos)
    piece = get_piece(start_pos)
    raise "Invalid move" unless piece.valid_moves(self).include?(end_pos)

    place_piece(piece, end_pos)
    remove_piece(start_pos)
  end

  def remove_piece(pos)
    row, col = pos
    @grid[row][col] = nil
  end

  def find_king(color)
    @grid.flatten.compact.find { |piece| piece.is_a?(King) && piece.color == color }.position
  end
end