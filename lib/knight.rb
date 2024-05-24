require_relative 'piece'

class Knight < Piece
  def initialize(position, color)
    super
    @symbol = color == :white ? "♞" : "♘"
  end

  def valid_moves(board)
    row, col = position
    potential_moves = [
      [row + 2, col + 1], [row + 2, col - 1],
      [row - 2, col + 1], [row - 2, col - 1],
      [row + 1, col + 2], [row + 1, col - 2],
      [row - 1, col + 2], [row - 1, col - 2]
    ]

    moves = potential_moves.select do |new_row, new_col|
      next unless new_row.between?(0, 7) && new_col.between?(0, 7)
      piece = board.get_piece([new_row, new_col])
      piece.nil? || piece.color != color
    end

    moves
  end
end