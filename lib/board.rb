require './lib/cell'
require "pry"
class Board

  attr_reader :cells
  def initialize()
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D2"),
      "D2" => Cell.new("D4"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coords)
    cells.find do |cell|
      if cell[1].coordinates == coords
        true
      else
        false
      end
    end
  end

  def valid_placement?(ship, placements)
    # binding.pry
    if ship.length == placements.size
      true
      # If the first coord num plus 1 equals the next coord num
    elsif split_coords(placements)[1].to_i + 1 == split_coords(placements)[3].to_i
      # Testing a ship with max length
      if split_coords(placements).size == 6
        if split_coords(placements)[3].to_i + 1 == split_coords(placements)[5].to_i
          true
        else
          false
        end
      else
        true
      end
      # Test valid placement of coord letter
    # elsif split_coords(placements)[0] ==
    end
  end

# Helper method to split coords to determine valid placements
  def split_coords(placements)
    placements.map do |coord|
      coord.split('')
    end
    placements
  end
end
