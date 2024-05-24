require 'rspec'
require_relative '../lib/game'
require_relative '../lib/serialization'

RSpec.describe Serialization do
  let(:game) { Game.new }
  let(:filename) { 'test_save_file' }

  after do
    File.delete(filename) if File.exist?(filename)
  end

  describe '.save_game' do
    it 'saves the game state to a file' do
      Serialization.save_game(game, filename)
      expect(File.exist?(filename)).to be true
    end
  end

  describe '.load_game' do
    it 'loads the game state from a file' do
      Serialization.save_game(game, filename)
      loaded_game = Serialization.load_game(filename)

      # Compare the board's state by comparing the positions and symbols of pieces
      loaded_board_state = loaded_game.board.grid.map do |row|
        row.map { |piece| piece.nil? ? nil : [piece.position, piece.symbol] }
      end

      original_board_state = game.board.grid.map do |row|
        row.map { |piece| piece.nil? ? nil : [piece.position, piece.symbol] }
      end

      expect(loaded_board_state).to eq(original_board_state)
      expect(loaded_game.current_player).to eq(game.current_player)
    end
  end
end