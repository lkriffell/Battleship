require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'
require './lib/turn'

exit_condition = false

until exit_condition == true
  puts "===================================="
  puts "Welcome to BATTLESHIP"
  puts "Enter p to play. Enter q to quit."
  puts "===================================="

  user_input = gets.chomp.downcase
  if user_input == 'p'

    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "Randy")
    player.board.get_board_size # not sure how to set both boards at once
    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "Jeeves => computer")
    computer.board.get_board_size # not sure how to set both boards at once
    turn = Turn.new(player, computer)

    turn.play_game
  elsif user_input == 'q'
    puts "Thanks for playing! Come again."
    exit_condition = true
    break
  else
    puts "Oops! Please enter a valid option."
  end

end
