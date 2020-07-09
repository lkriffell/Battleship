require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'
require './lib/turn'

class TurnTest < Minitest::Test

  def test_a_turn_exists
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    assert_instance_of Turn, turn
  end

  def test_players_can_shoot
    skip
    # Create player and computer objects here
    turn = Turn.new(player, computer)

  end
end
