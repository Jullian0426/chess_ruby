class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def get_piece(position)
    row, col = position
    grid[row][col]
  end

  def place_piece(piece, position)
    row, col = position
    grid[row][col] = piece
    piece.position = position
  end

  def move_piece(start_pos, end_pos)
    piece = get_piece(start_pos)
    raise "Invalid move" unless piece.valid_moves(self).include?(end_pos)

    place_piece(piece, end_pos)
    grid[start_pos[0]][start_pos[1]] = nil
  end
end