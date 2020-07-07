require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test
  def test_a_cell_exists_and_has_coords
    # Board goes up to D4 (4x4 square board)
    cell = cell.new("A1")# not sure if it should be ("A1") or ("A", 1) yet

    assert Cell, cell
    assert_equal "A1", cell.coordinates
  end

  def test_if_cell_is_not_holding_a_ship
    cell = cell.new("A1")

    assert cell.empty?
  end

  def test_ship_can_be_placed
    cell1 = cell.new("A1")
    # cell2 = cell.new("A2")
    # cell3 = cell.new("B1")
    submarine = ship.new("Submarine", 2)

    # not sure how this method will determine which 2 cells
    # the ship goes in so I created 3 cells

    #I'm not sure if one cell holds an entire ship
    cell1.place_ship(submarine)

    refute cell1.empty?
    # refute cell2.empty? || cell3.empty?
    # want either cell2 or cell3 to hold part of the ship
    # but if cell1 holds the whole ship I think thats whats intended for testing purpose
  end

  def test_ship_can_be_fired_upon
    cell1 = cell.new("A1")
    # cell2 = cell.new("A2")
    # cell3 = cell.new("B1")
    submarine = ship.new("Submarine", 2)
    cell1.place_ship(submarine)
    cell1.fire_upon

    assert_equal 1, submarine.health
  end

  def test_if_ship_knows_its_hit
    cell1 = cell.new("A1")
    # cell2 = cell.new("A2")
    # cell3 = cell.new("B1")
    submarine = ship.new("Submarine", 2)
    cell1.place_ship(submarine)
    cell1.fire_upon

    assert cell1.fired_upon?
  end

  def test_if_ship_knows_its_not_hit #redundant test
    cell1 = cell.new("A1")
    # cell2 = cell.new("A2")
    # cell3 = cell.new("B1")
    submarine = ship.new("Submarine", 2)
    cell1.place_ship(submarine)

    assert_equal false, cell1.fired_upon?
  end

  def test_cell_rendering_no_ship
    cell1 = cell.new("A1")
    submarine = ship.new("Submarine", 2)

    assert_equal ".", cell1.render
  end

  def test_cell_rendering_for_miss
    cell1 = cell.new("A1")

    assert_equal "M", cell1.render
  end

  def test_cell_rendering_for_hit
    cell1 = cell.new("A1")
    submarine = ship.new("Submarine", 2)
    cell1.place_ship(submarine)
    cell1.fire_upon

    assert_equal "H", cell1.render
  end

  def test_cell_rendering_for_sunk
    cell1 = cell.new("A1")
    submarine = ship.new("Submarine", 2)
    cell1.place_ship(submarine)
    cell1.fire_upon
    cell1.fire_upon

    assert_equal "X", cell1.render
  end

  def test_conditional_render
    cell1 = cell.new("A1")
    submarine = ship.new("Submarine", 2)

    assert_equal "S", cell1.render(true)
  end
end
