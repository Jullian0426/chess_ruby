require 'rspec'
require_relative '../lib/piece'
require_relative '../lib/pawn'
require_relative '../lib/board'

RSpec.describe Pawn do
  let(:board) { Board.new }

  describe '#valid_moves' do
    context 'when the pawn is white' do
      let(:pawn) { Pawn.new([6, 3], :white) }

      before do
        board.place_piece(pawn, [6, 3])
      end

      it 'can move one step forward' do
        expect(pawn.valid_moves(board)).to include([5, 3])
      end

      it 'can move two steps forward from the starting position' do
        expect(pawn.valid_moves(board)).to include([4, 3])
      end

      it 'cannot move forward if blocked' do
        board.place_piece(Pawn.new([5, 3], :black), [5, 3])
        expect(pawn.valid_moves(board)).not_to include([4, 3])
      end

      it 'can capture diagonally' do
        board.place_piece(Pawn.new([5, 2], :black), [5, 2])
        board.place_piece(Pawn.new([5, 4], :black), [5, 4])
        expect(pawn.valid_moves(board)).to include([5, 2], [5, 4])
      end

      it 'cannot capture diagonally if the target square is empty' do
        expect(pawn.valid_moves(board)).not_to include([5, 2], [5, 4])
      end
    end

    context 'when the pawn is black' do
      let(:pawn) { Pawn.new([1, 3], :black) }

      before do
        board.place_piece(pawn, [1, 3])
      end

      it 'can move one step forward' do
        expect(pawn.valid_moves(board)).to include([2, 3])
      end

      it 'can move two steps forward from the starting position' do
        expect(pawn.valid_moves(board)).to include([3, 3])
      end

      it 'cannot move forward if blocked' do
        board.place_piece(Pawn.new([2, 3], :white), [2, 3])
        expect(pawn.valid_moves(board)).not_to include([3, 3])
      end

      it 'can capture diagonally' do
        board.place_piece(Pawn.new([2, 2], :white), [2, 2])
        board.place_piece(Pawn.new([2, 4], :white), [2, 4])
        expect(pawn.valid_moves(board)).to include([2, 2], [2, 4])
      end

      it 'cannot capture diagonally if the target square is empty' do
        expect(pawn.valid_moves(board)).not_to include([2, 2], [2, 4])
      end
    end
  end
end