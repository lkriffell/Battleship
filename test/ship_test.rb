require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_ship_exists
    ship = Ship.new("Cruiser", 3)#The 3 refers to length

    assert Ship, ship
  end

  def test_ship_has_health
    skip
    ship = Ship.new("Cruiser", 3)

    assert_equal 3, ship.health
  end

  def test_ship_can_have_different_attributes
    skip
    ship = Ship.new("Submarine", 2)

    assert_equal 2, ship.health
    assert_equal "Submarine", ship.name
  end


  def test_ship_can_be_hit
    skip
    ship = Ship.new("Cruiser", 3)
    ship.hit

    assert_equal 2, ship.health
  end
  
  def test_ship_can_sink
    skip
    ship = Ship.new("Submarine", 0)

    assert_equal true, ship.sunk?
  end
end
