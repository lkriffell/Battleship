require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'
require './lib/turn'

player_board = Board.new
player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
player = Player.new(player_board, player_ships, "player")

computer_board = Board.new
computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
computer = Player.new(computer_board, computer_ships, "computer")
turn = Turn.new(player, computer)
turn.main_menu
