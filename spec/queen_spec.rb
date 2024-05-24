# spec/queen_spec.rb
require 'rspec'
require_relative '../lib/piece'
require_relative '../lib/queen'
require_relative '../lib/pawn'
require_relative '../lib/board'

RSpec.describe Queen do
  describe '#valid_moves' do
    let(:board) { Board.new }
    let(:queen) { Queen.new([3, 3], :white) }

    before do
      board.grid = Array.new(8) { Array.new(8) }  # Clear the board
      board.place_piece(queen, [3, 3])
    end

    it 'returns all possible vertical, horizontal, and diagonal moves on an empty board' do
      expected_moves = [
        # Vertical
        [0, 3], [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3],
        # Horizontal
        [3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7],
        # Diagonal
        [2, 2], [1, 1], [0, 0], [2, 4], [1, 5], [0, 6],
        [4, 2], [5, 1], [6, 0], [4, 4], [5, 5], [6, 6], [7, 7]
      ]

      actual_moves = queen.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'stops at other pieces of the same color' do
      board.place_piece(Pawn.new([1, 3], :white), [1, 3])
      board.place_piece(Pawn.new([3, 5], :white), [3, 5])

      expected_moves = [
        [2, 3], [4, 3], [5, 3], [6, 3], [7, 3],
        [3, 0], [3, 1], [3, 2], [3, 4],
        [2, 2], [1, 1], [0, 0], [2, 4], [1, 5], [0, 6],
        [4, 2], [5, 1], [6, 0], [4, 4], [5, 5], [6, 6], [7, 7]
      ]

      actual_moves = queen.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'can capture pieces of the opposite color' do
      board.place_piece(Pawn.new([1, 3], :black), [1, 3])
      board.place_piece(Pawn.new([3, 5], :black), [3, 5])

      expected_moves = [
        [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3],
        [3, 0], [3, 1], [3, 2], [3, 4], [3, 5],
        [2, 2], [1, 1], [0, 0], [2, 4], [1, 5], [0, 6],
        [4, 2], [5, 1], [6, 0], [4, 4], [5, 5], [6, 6], [7, 7]
      ]

      actual_moves = queen.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end
  end
end