# lib/queen.rb
require_relative 'piece'

class Queen < Piece
  def initialize(position, color)
    super
    @symbol = color == :white ? "♛" : "♕"
  end

  def valid_moves(board)
    directions = [
      [-1, 0], [1, 0], [0, -1], [0, 1],  # Rook-like moves
      [-1, -1], [-1, 1], [1, -1], [1, 1] # Bishop-like moves
    ]
    moves = []

    directions.each do |dir|
      add_moves_in_direction(board, moves, dir)
    end

    moves
  end

  private

  def add_moves_in_direction(board, moves, direction)
    row, col = position
    loop do
      row += direction[0]
      col += direction[1]
      break unless row.between?(0, 7) && col.between?(0, 7)

      next_pos = [row, col]
      piece = board.get_piece(next_pos)
      if piece.nil?
        moves << next_pos
      else
        moves << next_pos if piece.color != color
        break
      end
    end
  end
end