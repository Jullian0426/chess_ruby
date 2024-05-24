require_relative 'rules'

class Game
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
    setup_board
  end

  def setup_board
    place_pieces(:black, 0, 1)
    place_pieces(:white, 7, 6)
  end

  def place_pieces(color, back_row, pawn_row)
    pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]

    pieces.each_with_index do |piece_class, col|
      @board.place_piece(piece_class.new([back_row, col], color), [back_row, col])
    end

    8.times do |col|
      @board.place_piece(Pawn.new([pawn_row, col], color), [pawn_row, col])
    end
  end

  def switch_player
    @current_player = @current_player == :white ? :black : :white
  end

  def move_piece(start_pos, end_pos)
    piece = @board.get_piece(start_pos)
    raise "Invalid move: Piece not found at #{start_pos}" if piece.nil?
    raise "Invalid move: Not your turn" if piece.color != @current_player
  
    # Temporarily make the move
    new_board = Rules.deep_dup_board(@board)
    new_board.move_piece(start_pos, end_pos)
  
    # Check if the move resolves check
    if Rules.check?(new_board, @current_player)
      raise "Invalid move: You cannot move into check"
    else
      # Make the move on the actual board
      @board.move_piece(start_pos, end_pos)
      switch_player
    end
  end
end