require 'rspec'
require_relative '../lib/rules'
require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/king'
require_relative '../lib/queen'
require_relative '../lib/rook'
require_relative '../lib/bishop'
require_relative '../lib/knight'
require_relative '../lib/pawn'

RSpec.describe Rules do
  let(:board) { Board.new }

  describe '#check?' do
    it 'detects check' do
      king = King.new([0, 4], :white)
      rook = Rook.new([1, 4], :black)
      board.place_piece(king, [0, 4])
      board.place_piece(rook, [1, 4])
      expect(Rules.check?(board, :white)).to be true
    end

    it 'does not detect check when no check exists' do
      king = King.new([0, 4], :white)
      rook = Rook.new([1, 5], :black)
      board.place_piece(king, [0, 4])
      board.place_piece(rook, [1, 5])
      expect(Rules.check?(board, :white)).to be false
    end
  end

  describe '#checkmate?' do
    it 'detects checkmate' do
      king = King.new([0, 4], :white)
      rook1 = Rook.new([1, 4], :black)
      rook2 = Rook.new([1, 3], :black)
      rook3 = Rook.new([1, 5], :black)
      rook4 = Rook.new([0, 3], :black)
      rook5 = Rook.new([0, 5], :black)
      board.place_piece(king, [0, 4])
      board.place_piece(rook1, [1, 4])
      board.place_piece(rook2, [1, 3])
      board.place_piece(rook3, [1, 5])
      board.place_piece(rook4, [0, 3])
      board.place_piece(rook5, [0, 5])
      expect(Rules.checkmate?(board, :white)).to be true
    end

    it 'does not detect checkmate when no checkmate exists' do
      king = King.new([0, 4], :white)
      rook = Rook.new([1, 4], :black)
      board.place_piece(king, [0, 4])
      board.place_piece(rook, [1, 4])
      expect(Rules.checkmate?(board, :white)).to be false
    end
  end

  describe '#stalemate?' do
    it 'detects stalemate' do
      king = King.new([0, 4], :white)
      rook1 = Rook.new([1, 5], :black)
      rook2 = Rook.new([1, 3], :black)
      board.place_piece(king, [0, 4])
      board.place_piece(rook1, [1, 5])
      board.place_piece(rook2, [1, 3])
      expect(Rules.stalemate?(board, :white)).to be true
    end

    it 'does not detect stalemate when no stalemate exists' do
      king = King.new([0, 4], :white)
      rook = Rook.new([1, 5], :black)
      board.place_piece(king, [0, 4])
      board.place_piece(rook, [1, 5])
      expect(Rules.stalemate?(board, :white)).to be false
    end
  end
end