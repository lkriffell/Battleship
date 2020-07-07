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
    if validate_numbers_consecutive(placements) == true
      if ship.length == placements.size
        placement_length = true
        if placement_length == true
          if validate_letters_consecutive(placements) == true
            true
          end
        end
      end
    else
      false
    end
  end

# Helper method to split coords to determine valid placements
  def split_coords(placements)
    coords = []
    placements.map do |coord|
      coords << coord.split('')
    end
    coords.join.split('')
  end

  def validate_numbers_consecutive(placements)
    coords = split_coords(placements)
    # If the first coord num plus 1 equals the next coord num
    # And the first coord letter equals the third coord letter
    if coords[1].to_i + 1 == coords[3].to_i && coords[0] == coords[2] || coords[1].to_i == coords[3].to_i && coords[0].ord + 1 == coords[2].ord
      # Testing a ship with max length
      if coords.size == 6
        if coords[3].to_i + 1 == coords[5].to_i && coords[2] == coords[4] || coords[3].to_i == coords[5].to_i && coords[2].ord + 1 == coords[4].ord
          true
        else
          false
        end
      else
        true
      end
    else
      false
    end
  end

  def validate_letters_consecutive(placements)
    coords = split_coords(placements)
    if coords[1].to_i != coords[3].to_i && coords[0] == coords[2] || coords[1].to_i == coords[3].to_i && coords[0].ord + 1 == coords[2].ord
      if coords.size == 6
        if coords[3].to_i != coords[5].to_i && coords[2] == coords[4] || coords[3].to_i == coords[5].to_i && coords[2].ord + 1 == coords[4].ord
          true
        else
          binding.pry
          false
        end
      else
        true
      end
    else
      binding.pry
      false
    end
  end
end
