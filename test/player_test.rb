require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_player_and_computer_exists
    board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(board, player_ships, "player")

    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(board, computer_ships, "computer")

    assert_instance_of Player, player
    assert_instance_of Player, computer
  end

  def test_player_can_lose
    board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(board, player_ships, "player")
    # require "pry"; binding.pry
    player_ships[:submarine].hit
    player_ships[:submarine].hit
    player_ships[:cruiser].hit
    player_ships[:cruiser].hit
    player_ships[:cruiser].hit
    
    assert player.has_lost?
  end


end
