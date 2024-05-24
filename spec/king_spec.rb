# spec/king_spec.rb
require 'rspec'
require_relative '../lib/piece'
require_relative '../lib/king'
require_relative '../lib/pawn'
require_relative '../lib/board'

RSpec.describe King do
  describe '#valid_moves' do
    let(:board) { Board.new }
    let(:king) { King.new([3, 3], :white) }

    before do
      board.grid = Array.new(8) { Array.new(8) }  # Clear the board
      board.place_piece(king, [3, 3])
    end

    it 'returns all possible moves on an empty board' do
      expected_moves = [
        [2, 3], [4, 3], [3, 2], [3, 4], [2, 2], [2, 4], [4, 2], [4, 4]
      ]

      actual_moves = king.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'stops at other pieces of the same color' do
      board.place_piece(Pawn.new([2, 3], :white), [2, 3])
      board.place_piece(Pawn.new([3, 4], :white), [3, 4])

      expected_moves = [
        [4, 3], [3, 2], [2, 2], [2, 4], [4, 2], [4, 4]
      ]

      actual_moves = king.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'can capture pieces of the opposite color' do
      board.place_piece(Pawn.new([2, 3], :black), [2, 3])
      board.place_piece(Pawn.new([3, 4], :black), [3, 4])

      expected_moves = [
        [2, 3], [4, 3], [3, 2], [3, 4], [2, 2], [2, 4], [4, 2], [4, 4]
      ]

      actual_moves = king.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end
  end
end