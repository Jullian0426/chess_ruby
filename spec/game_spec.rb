require 'rspec'
require_relative '../lib/game'
require_relative '../lib/rules'
require_relative '../lib/serialization'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'sets up the board correctly' do
      expect(game.board.get_piece([0, 0])).to be_a(Rook)
      expect(game.board.get_piece([0, 1])).to be_a(Knight)
      expect(game.board.get_piece([0, 2])).to be_a(Bishop)
      expect(game.board.get_piece([0, 3])).to be_a(Queen)
      expect(game.board.get_piece([0, 4])).to be_a(King)
      expect(game.board.get_piece([1, 0])).to be_a(Pawn)
    end

    it 'sets the current player to white' do
      expect(game.current_player).to eq(:white)
    end
  end

  describe '#move_piece' do
    it 'switches player after a valid move' do
      game.board.place_piece(Pawn.new([6, 0], :white), [6, 0])
      game.move_piece([6, 0], [5, 0])
      expect(game.current_player).to eq(:black)
    end

    it 'raises an error for an invalid move' do
      expect { game.move_piece([0, 0], [3, 3]) }.to raise_error(RuntimeError, "Invalid move: Not your turn")
    end
  end
end