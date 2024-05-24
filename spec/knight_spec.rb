require 'rspec'
require_relative '../lib/piece'
require_relative '../lib/knight'
require_relative '../lib/pawn'
require_relative '../lib/board'

RSpec.describe Knight do
  describe '#valid_moves' do
    let(:board) { Board.new }
    let(:knight) { Knight.new([3, 3], :white) }

    before do
      board.grid = Array.new(8) { Array.new(8) }  # Clear the board
      board.place_piece(knight, [3, 3])
    end

    it 'returns all possible L-shaped moves on an empty board' do
      expected_moves = [
        [5, 4], [5, 2], [1, 4], [1, 2],
        [4, 5], [4, 1], [2, 5], [2, 1]
      ]

      actual_moves = knight.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'stops at other pieces of the same color' do
      board.place_piece(Pawn.new([5, 4], :white), [5, 4])
      board.place_piece(Pawn.new([2, 1], :white), [2, 1])

      expected_moves = [
        [5, 2], [1, 4], [1, 2],
        [4, 5], [4, 1], [2, 5]
      ]

      actual_moves = knight.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end

    it 'can capture pieces of the opposite color' do
      board.place_piece(Pawn.new([5, 4], :black), [5, 4])
      board.place_piece(Pawn.new([2, 1], :black), [2, 1])

      expected_moves = [
        [5, 4], [5, 2], [1, 4], [1, 2],
        [4, 5], [4, 1], [2, 5], [2, 1]
      ]

      actual_moves = knight.valid_moves(board)
      expect(actual_moves).to match_array(expected_moves)
    end
  end
end