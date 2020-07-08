require './lib/cell'


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
      return true if cell[1].coordinates == coords
    end
  end

  def valid_placement?(ship, placements)
    if ship_overlap?(placements) == true
      return false
    elsif validate_cell_placements_consecutive(placements) == true && ship.length == placements.size
      true
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

  def validate_cell_placements_consecutive(placements)
    coords = split_coords(placements)
    # If the first coord num plus 1 equals the next coord num
    # And the first coord letter equals the next coord letter
    # OR
    # If the first coord num equals the next coord num
    # And the first coord letter plus one equals the next coord letter
    if coords[1].to_i + 1 == coords[3].to_i && coords[0] == coords[2] || coords[1].to_i == coords[3].to_i && coords[0].ord + 1 == coords[2].ord
      # Testing a ship with max length
      if coords.size == 6
        if coords[3].to_i + 1 == coords[5].to_i && coords[2] == coords[4] || coords[3].to_i == coords[5].to_i && coords[2].ord + 1 == coords[4].ord
          true
        end
      else
        true
      end
    end
  end

  def ship_overlap?(placements)

    @cells.each do |cell|
      if cell[1].ship == nil
        return false
      else
        break
      end
    end


    acc = []

    @cells.each do |cell|
      if cell[1].ship != nil
        acc << cell
      end
    end

    acc.each do |cell|
      if placements.length == 2
        if cell[0] == placements[0] || placements[1]
          return true
        end
      elsif placements.length == 3
        if cell[0] == placements[0] || placements[1] || placements[2]
          return true
        end
      end
    end

  end

  def place(ship, coords)
    index = 0

    coords.length.times do
      @cells[coords[index]].place_ship(ship)
      index += 1
    end
  end

  #FIX ME: I will refactor later with easier to read code
  def render(show_ship = false)
    if show_ship == true
      return "  1 2 3 4 \nA #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \nB #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \nC #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \nD #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n"
    else
      return "  1 2 3 4 \nA #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \nB #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \nC #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \nD #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n"
    end
  end
end
