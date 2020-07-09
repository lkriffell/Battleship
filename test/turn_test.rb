require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
# require './lib/player'

class TurnTest < Minitest::Test

  def test_a_turn_exists
    # Create player and computer objects here
    turn = Turn.new(player, computer)

    assert_instance_of Turn, turn
  end

  def test_players_can_shoot
    skip
    # Create player and computer objects here
    turn = Turn.new(player, computer)
    
  end
end
