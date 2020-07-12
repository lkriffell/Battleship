require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'

class BoardTest < Minitest::Test

  def test_a_board_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_valid_and_invalid_coordinates
    board = Board.new
    board.set_board_size(999, 999)

    assert board.valid_coordinate?("A1")
    refute board.valid_coordinate?("A1000")
  end

  def test_valid_placement_of_ships
    board = Board.new
    board.set_board_size(4, 4)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    # placement has to be same length as ship
    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A8", "A9", "A10"])

    # coordinates must be consecutive
    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])

    # coordinates can’t be diagonal
    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute board.valid_placement?(submarine, ["C2", "D3"])

    # if all the previous checks pass then the placement should be valid
    assert_equal true, board.valid_placement?(submarine, ["A10", "A11"])
    assert_equal true, board.valid_placement?(cruiser, ["B10", "C10", "D10"])
  end

  def test_validate_cell_placements_consecutive
    board = Board.new
    board.set_board_size(115, 115)

    assert board.validate_cell_placements_consecutive(["A109", "A110"])
    assert board.validate_cell_placements_consecutive(["B107", "C107", "D107"])
  end

  def test_it_can_place_board
    board = Board.new
    board.set_board_size(4, 4)
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_overlapping_ship_2?
    board = Board.new
    board.set_board_size(4, 4)
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_overlapping_ship_3?
    board = Board.new
    board.set_board_size(4, 4)
    submarine = Ship.new("Submarine", 2)

    board.place(submarine, ["C4", "D4"])

    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["D2", "D3", "D4"])
  end

  def test_board_render
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.set_board_size(4, 4)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . .", board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . .", board.render(true)
  end

  def test_get_board_size
    board = Board.new
    board.set_board_size(7, 7)

    assert_equal 49, board.cells.count
  end
end
