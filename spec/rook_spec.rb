require 'rspec'
require_relative '../lib/piece'
require_relative '../lib/rook'
require_relative '../lib/pawn'
require_relative '../lib/board'

RSpec.describe Rook do
  describe '#valid_moves' do
    let(:board) { Board.new }
    let(:rook) { Rook.new([3, 3], :white) }

    before do
      board.grid = Array.new(8) { Array.new(8) }  # Clear the board
      board.place_piece(rook, [3, 3])
    end

    it 'returns all possible vertical and horizontal moves on an empty board' do
      expected_moves = [
        [0, 3], [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3], # Vertical
        [3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7]  # Horizontal
      ]

      actual_moves = rook.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'stops at other pieces of the same color' do
      board.place_piece(Pawn.new([1, 3], :white), [1, 3])
      board.place_piece(Pawn.new([3, 5], :white), [3, 5])

      expected_moves = [
        [2, 3], [4, 3], [5, 3], [6, 3], [7, 3],
        [3, 0], [3, 1], [3, 2], [3, 4]
      ]

      actual_moves = rook.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'can capture pieces of the opposite color' do
      board.place_piece(Pawn.new([1, 3], :black), [1, 3])
      board.place_piece(Pawn.new([3, 5], :black), [3, 5])

      expected_moves = [
        [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3],
        [3, 0], [3, 1], [3, 2], [3, 4], [3, 5]
      ]

      actual_moves = rook.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end
  end
end