module Rules
  def self.check?(board, color)
    king_position = board.find_king(color)
    in_check = board.grid.flatten.compact.any? do |piece|
      piece.color != color && piece.valid_moves(board).include?(king_position)
    end
    in_check
  end

  def self.checkmate?(board, color)
    return false unless check?(board, color)

    board.grid.flatten.compact.each do |piece|
      next if piece.color != color

      piece.valid_moves(board).each do |move|
        new_board = deep_dup_board(board)
        new_board.move_piece(piece.position, move)
        unless check?(new_board, color)
          return false
        end
      end
    end

    true
  end

  def self.stalemate?(board, color)
    return false if check?(board, color)

    board.grid.flatten.compact.each do |piece|
      next if piece.color != color

      piece.valid_moves(board).each do |move|
        new_board = deep_dup_board(board)
        new_board.move_piece(piece.position, move)
        unless check?(new_board, color)
          return false
        end
      end
    end

    true
  end

  def self.deep_dup_board(board)
    new_board = Board.new
    new_board.grid = board.grid.map do |row|
      row.map { |piece| piece.nil? ? nil : piece.dup }
    end
    new_board
  end
end