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
    skip
    board = Board.new

    assert board.valid_coordinate?("A1")
    refute board.valid_coordinate?("A5")
  end

  def test_valid_placement_of_ships
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    # placement has to be same length as ship
    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])

    # coordinates must be consecutive
    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])

    # coordinates can’t be diagonal
    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute board.valid_placement?(submarine, ["C2", "D3"])

    # if all the previous checks pass then the placement should be valid
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_it_can_place_board
    skip
    board = Board.new
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
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_overlapping_ship_3?
    skip
    board = Board.new
    submarine = Ship.new("Submarine", 2)

    board.place(submarine, ["C4", "D4"])

    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["D2", "D3", "D4"])
  end

  def test_board_render
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", board.render(true)
  end

  def test_get_board_size
    board = Board.new
    board.get_board_size
  end
end
