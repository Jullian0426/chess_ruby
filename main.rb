require_relative 'lib/piece'
require_relative 'lib/pawn'
require_relative 'lib/rook'
require_relative 'lib/knight'
require_relative 'lib/bishop'
require_relative 'lib/queen'
require_relative 'lib/king'
require_relative 'lib/board'

# Initialize the board
board = Board.new

# Display the initial state of the board
board.display

# Main game loop
loop do
  # Example interaction: prompt for move
  puts "Enter the start position (e.g., 'a2'):"
  start_pos = gets.chomp
  puts "Enter the end position (e.g., 'a3'):"
  end_pos = gets.chomp

  # Convert positions from chess notation to array indices
  start_row, start_col = 8 - start_pos[1].to_i, start_pos[0].ord - 'a'.ord
  end_row, end_col = 8 - end_pos[1].to_i, end_pos[0].ord - 'a'.ord

  begin
    # Make the move
    board.move_piece([start_row, start_col], [end_row, end_col])
  rescue => e
    puts e.message
  end

  # Display the updated state of the board
  board.display

  # Add logic to check for check, checkmate, or game over conditions
end