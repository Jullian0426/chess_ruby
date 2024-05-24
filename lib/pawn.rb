require_relative 'piece'

class Pawn < Piece
  def initialize(position, color)
    super
    @symbol = color == :white ? "♙" : "♟"
  end

  def valid_moves(board)
    row, col = position
    direction = color == :white ? -1 : 1
    moves = []

    # Single step forward
    forward_pos = [row + direction, col]
    moves << forward_pos if board.get_piece(forward_pos).nil?

    # Double step forward on first move
    start_row = color == :white ? 6 : 1
    double_step_pos = [row + 2 * direction, col]
    moves << double_step_pos if row == start_row && board.get_piece(forward_pos).nil? && board.get_piece(double_step_pos).nil?

    # Capture diagonally
    [-1, 1].each do |offset|
      capture_pos = [row + direction, col + offset]
      if capture_pos.all? { |coord| coord.between?(0, 7) }
        piece = board.get_piece(capture_pos)
        moves << capture_pos if piece && piece.color != color
      end
    end

    moves
  end
end