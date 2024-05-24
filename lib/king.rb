# lib/king.rb
class King < Piece
  def initialize(position, color)
    super
    @symbol = color == :white ? "♚" : "♔"
  end

  def valid_moves(board)
    row, col = position
    moves = []

    directions = [
      [-1,  0], [1,  0], # Vertical
      [0, -1], [0,  1], # Horizontal
      [-1, -1], [-1, 1], # Diagonal
      [1, -1], [1,  1]  # Diagonal
    ]

    directions.each do |drow, dcol|
      new_row, new_col = row + drow, col + dcol
      next unless new_row.between?(0, 7) && new_col.between?(0, 7)

      piece = board.get_piece([new_row, new_col])
      if piece.nil?
        moves << [new_row, new_col]
      elsif piece.color != color
        moves << [new_row, new_col]
      end
    end

    moves
  end
end