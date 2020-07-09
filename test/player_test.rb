require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_a_player_exists
    board = Board.new
    ships = [submarine = Ship.new("submarine", 2), cruiser = Ship.new("Cruiser", 3)]
    # Not sure if ships should be a hash or an array
    player = Player.new(board, ships, "player")
    assert_instance_of Player, player
  end
end
