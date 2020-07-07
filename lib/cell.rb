require './lib/ship'

class Cell

  attr_reader :coordinates, :has_been_fired_on

  def initialize(coordinates)
    @coordinates = coordinates
    @ship = nil
    @has_been_fired_on = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @has_been_fired_on = true
    return @ship.hit if empty? == false
  end

  # Passes test for now but may need to be changed.
  # if cell is empty but has been fired up before? might cause issue
  def fired_upon?
    @has_been_fired_on
  end

  def render(conditional = false)
    if conditional == true
      "S"
    elsif fired_upon? == true && empty? == true
      "M"
    elsif fired_upon? == true && @ship.sunk? == true
      "X"
    elsif fired_upon? == true && empty? == false
      "H"
    elsif fired_upon? == false
      "."
    end
  end

end
