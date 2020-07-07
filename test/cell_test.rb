require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test

  def test_a_cell_exists_and_has_coords
    # Board goes up to D4 (4x4 square board)
    cell = Cell.new("A1")

    assert_instance_of Cell, cell
    assert_equal "A1", cell.coordinates
  end

  def test_if_cell_is_not_holding_a_ship
    cell = Cell.new("A1")

    assert cell.empty?
  end

  def test_ship_can_be_placed
    skip
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)

    refute cell_1.empty?
  end

  def test_ship_can_be_fired_upon
    skip
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)
    cell_1.fire_upon

    assert_equal 1, submarine.health
  end

  def test_if_ship_knows_its_hit
    skip
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)
    cell_1.fire_upon

    assert cell_1.fired_upon?
  end

  def test_if_ship_knows_its_not_hit #redundant test
    skip
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)

    assert_equal false, cell_1.fired_upon?
  end

  def test_cell_rendering_no_ship
    skip
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)

    assert_equal ".", cell_1.render
  end

  def test_cell_rendering_for_miss
    skip
    cell_1 = Cell.new("A1")

    assert_equal "M", cell_1.render
  end

  def test_cell_rendering_for_hit
    skip
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)
    cell_1.fire_upon

    assert_equal "H", cell_1.render
  end

  def test_cell_rendering_for_sunk
    skip
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)
    cell_1.fire_upon
    cell_1.fire_upon

    assert_equal "X", cell_1.render
  end

  def test_conditional_render
    skip
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)

    assert_equal "S", cell_1.render(true)
  end
end
