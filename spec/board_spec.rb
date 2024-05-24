require 'rspec'
require_relative '../lib/piece'
require_relative '../lib/board'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#initialize' do
    it 'creates an 8x8 grid' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true
    end
  end

  describe '#place_piece' do
    it 'places a piece on the board' do
      piece = Piece.new([0, 0], :white)
      board.place_piece(piece, [0, 0])
      expect(board.get_piece([0, 0])).to eq(piece)
    end
  end

  describe '#move_piece' do
    it 'moves a piece to a new position' do
      piece = Piece.new([0, 0], :white)
      board.place_piece(piece, [0, 0])
      allow(piece).to receive(:valid_moves).and_return([[0, 5]])
      board.move_piece([0, 0], [0, 5])
      expect(board.get_piece([0, 5])).to eq(piece)
      expect(board.get_piece([0, 0])).to be_nil
    end

    it 'raises an error for an invalid move' do
      piece = Piece.new([0, 0], :white)
      board.place_piece(piece, [0, 0])
      allow(piece).to receive(:valid_moves).and_return([])
      expect { board.move_piece([0, 0], [2, 0]) }.to raise_error("Invalid move")
    end
  end
end