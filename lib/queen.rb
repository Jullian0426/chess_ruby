# lib/queen.rb
require_relative 'piece'

class Queen < Piece
  def initialize(position, color)
    super
    @symbol = color == :white ? "♕" : "♛"
  end

  def valid_moves(board)
    row, col = position
    moves = []

    # Rook-like moves
    add_moves_in_direction(board, moves, row, col, -1, 0) # Vertical up
    add_moves_in_direction(board, moves, row, col, 1, 0)  # Vertical down
    add_moves_in_direction(board, moves, row, col, 0, -1) # Horizontal left
    add_moves_in_direction(board, moves, row, col, 0, 1)  # Horizontal right

    # Bishop-like moves
    add_moves_in_direction(board, moves, row, col, -1, -1) # Diagonal top-left
    add_moves_in_direction(board, moves, row, col, -1, 1)  # Diagonal top-right
    add_moves_in_direction(board, moves, row, col, 1, -1)  # Diagonal bottom-left
    add_moves_in_direction(board, moves, row, col, 1, 1)   # Diagonal bottom-right

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