require 'rspec'
require_relative '../lib/piece'
require_relative '../lib/bishop'
require_relative '../lib/pawn'
require_relative '../lib/board'

RSpec.describe Bishop do
  describe '#valid_moves' do
    let(:board) { Board.new }
    let(:bishop) { Bishop.new([3, 3], :white) }

    before do
      board.grid = Array.new(8) { Array.new(8) }  # Clear the board
      board.place_piece(bishop, [3, 3])
    end

    it 'returns all possible diagonal moves on an empty board' do
      expected_moves = [
        [0, 0], [1, 1], [2, 2], [4, 4], [5, 5], [6, 6], [7, 7], # Top-right and bottom-left
        [0, 6], [1, 5], [2, 4], [4, 2], [5, 1], [6, 0]           # Top-left and bottom-right
      ]

      actual_moves = bishop.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'stops at other pieces of the same color' do
      board.place_piece(Pawn.new([1, 1], :white), [1, 1])
      board.place_piece(Pawn.new([5, 5], :white), [5, 5])

      expected_moves = [
        [2, 2], [4, 4],
        [0, 6], [1, 5], [2, 4], [4, 2], [5, 1], [6, 0]
      ]

      actual_moves = bishop.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'can capture pieces of the opposite color' do
      board.place_piece(Pawn.new([1, 1], :black), [1, 1])
      board.place_piece(Pawn.new([5, 5], :black), [5, 5])

      expected_moves = [
        [1, 1], [2, 2], [4, 4], [5, 5],
        [0, 6], [1, 5], [2, 4], [4, 2], [5, 1], [6, 0]
      ]

      actual_moves = bishop.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end
  end
end