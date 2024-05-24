require_relative 'lib/board'
require_relative 'lib/game'
require_relative 'lib/rules'
require_relative 'lib/serialization'
require_relative 'lib/piece'
require_relative 'lib/king'
require_relative 'lib/queen'
require_relative 'lib/rook'
require_relative 'lib/bishop'
require_relative 'lib/knight'
require_relative 'lib/pawn'

COLUMN_MAP = ('a'..'h').to_a

def print_board(board)
  puts "  a b c d e f g h"
  board.grid.each_with_index do |row, index|
    print "#{8 - index} "
    row.each do |cell|
      print cell.nil? ? ". " : "#{cell.symbol} "
    end
    puts " #{8 - index}"
  end
  puts "  a b c d e f g h"
end

def get_move
  puts "Enter your move in the format 'start_square end_square' (e.g., 'a7 a8' to move a piece from a7 to a8), or type 'save' or 'load':"
  input = gets.chomp

  if input.downcase == 'save'
    return 'save'
  elsif input.downcase == 'load'
    return 'load'
  end

  start_square, end_square = input.split
  start_pos = algebraic_to_coordinates(start_square)
  end_pos = algebraic_to_coordinates(end_square)

  [start_pos, end_pos]
end

def algebraic_to_coordinates(square)
  col = COLUMN_MAP.index(square[0])
  row = 8 - square[1].to_i
  [row, col]
end

def game_loop
  game = Game.new

  loop do
    system('clear')
    print_board(game.board)
    puts "#{game.current_player.capitalize}'s turn."

    input = get_move

    if input == 'save'
      puts "Enter the filename to save the game:"
      filename = gets.chomp
      Serialization.save_game(game, filename)
      puts "Game saved to #{filename}"
      sleep(2)
      next
    elsif input == 'load'
      puts "Enter the filename to load the game:"
      filename = gets.chomp
      if File.exist?(filename)
        game = Serialization.load_game(filename)
        puts "Game loaded from #{filename}"
      else
        puts "File not found."
      end
      sleep(2)
      next
    else
      start_pos, end_pos = input
      begin
        game.move_piece(start_pos, end_pos)
      rescue => e
        puts e.message
        puts "Invalid move, try again."
        sleep(2)
        next
      end
    end

    if Rules.checkmate?(game.board, game.current_player == :white ? :black : :white)
      puts "#{game.current_player.capitalize} wins by checkmate!"
      break
    elsif Rules.stalemate?(game.board, game.current_player == :white ? :black : :white)
      puts "The game is a stalemate."
      break
    elsif Rules.check?(game.board, game.current_player)
      puts "Check!"
      sleep(2)
    end
  end
end

game_loop