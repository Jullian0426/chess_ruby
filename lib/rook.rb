require_relative 'piece'

class Rook < Piece
  def initialize(position, color)
    super
    @symbol = color == :white ? "♖" : "♜"
  end

  def valid_moves(board)
    row, col = position
    moves = []

    # Vertical moves upwards
    add_moves_in_direction(board, moves, row, col, -1, 0)
    # Vertical moves downwards
    add_moves_in_direction(board, moves, row, col, 1, 0)
    # Horizontal moves to the left
    add_moves_in_direction(board, moves, row, col, 0, -1)
    # Horizontal moves to the right
    add_moves_in_direction(board, moves, row, col, 0, 1)

    moves
  end

  private

  def add_moves_in_direction(board, moves, start_row, start_col, row_dir, col_dir)
    row, col = start_row + row_dir, start_col + col_dir

    while row.between?(0, 7) && col.between?(0, 7)
      piece = board.get_piece([row, col])
      if piece.nil?
        moves << [row, col]
      elsif piece.color != color
        moves << [row, col]
        break
      else
        break
      end
      row += row_dir
      col += col_dir
    end
  end
end