require './lib/cell'


class Board

  attr_reader :cells, :letters, :width
  def initialize()
    @cells = {
      # Uncomment @cells for testing variable board
      # "A1" => Cell.new("A1"),
      # "A2" => Cell.new("A2"),
      # "A3" => Cell.new("A3"),
      # "A4" => Cell.new("A4"),
      # "B1" => Cell.new("B1"),
      # "B2" => Cell.new("B2"),
      # "B3" => Cell.new("B3"),
      # "B4" => Cell.new("B4"),
      # "C1" => Cell.new("C1"),
      # "C2" => Cell.new("C2"),
      # "C3" => Cell.new("C3"),
      # "C4" => Cell.new("C4"),
      # "D1" => Cell.new("D1"),
      # "D2" => Cell.new("D2"),
      # "D3" => Cell.new("D3"),
      # "D4" => Cell.new("D4")
    }
    @letters = letters
    @width = width

  end


  def valid_coordinate?(coords)
    # split_coords(coords)
      @cells.include?(coords)
      # cell.coordinates == coords
  end

  def valid_placement?(ship, placements)
    return false if ship_overlap?(placements) == true
    return true if validate_cell_placements_consecutive(placements) == true && ship.length == placements.size
  end

  # Helper method to split coords to determine valid placements
  def split_coords(placements)
    coords = []
    placements.map do |coord|
      split_up_coords = coord.split('')
      if split_up_coords.size == 3
        coords << split_up_coords[0]
        coords << split_up_coords[1..2].join
      elsif split_up_coords.size == 4
        coords << split_up_coords[0]
        coords << split_up_coords[1..3].join
      else
        coords << split_up_coords[0]
        coords << split_up_coords[1]
      end
    end
  end

  def validate_cell_placements_consecutive(placements)
    coords = split_coords(placements).first
    # If the first coord num plus 1 equals the next coord num
    # And the first coord letter equals the next coord letter
    if coords[1].to_i + 1 == coords[3].to_i && coords[0] == coords[2]
      horizontal = true
      if coords.size == 6 && horizontal == true
        if coords[3].to_i + 1 == coords[5].to_i && coords[2] == coords[4]
          true
        end
      else
        true
      end
      # If the first coord num equals the next coord num
      # And the first coord letter plus one equals the next coord letter
    elsif horizontal == nil && coords[1].to_i == coords[3].to_i && coords[0].ord + 1 == coords[2].ord
      if coords.size == 6
        if coords[3].to_i == coords[5].to_i && coords[2].ord + 1 == coords[4].ord
          true
        end
      else
        true
      end
    end
  end

  def ship_overlap?(placements)

    # runs through all cells and if found a ship stored into
    # a cell will place it into accumulator
    acc = []
    cells.each do |cell|
      if cell[1].ship != nil
        acc << cell[1]
      end
    end

    # compares each cell that contains a ship to the placement
    # coordinates given and return true or false if overlapping
    acc.each do |cell|
      if placements.length == 2
        if cell.coordinates == placements[0] || cell.coordinates == placements[1]
          return true
        end
      elsif placements.length == 3
        if cell.coordinates == placements[0] || cell.coordinates == placements[1] || cell.coordinates == placements[2]
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

  def render(show_ship = false)
    board_string = " "
    count = 1
    num_array = []

    @width.times do
      board_string << " #{count}"
      num_array << count
      count += 1
    end

    @letters.each do |letter|
      board_string << " \n#{letter.upcase}"
      num_array.each do |number|
        if show_ship == true
          board_string << " #{@cells["#{letter.upcase + number.to_s}"].render(true)}"
        else
          board_string << " #{@cells["#{letter.upcase + number.to_s}"].render}"
        end
      end
    end
    board_string
  end

  def set_board_size(height, width)

    @width = width

    alphabet = ('a'..'z').to_a
    @letters = alphabet[0..height - 1]

    letters.each do |letter|
      column = 1
      width.times do
        coord = letter + column.to_s
        @cells[coord.upcase] = Cell.new(coord.upcase)
        coord = ''
        column += 1
      end
    end

  end #get_board_size

end #board class
