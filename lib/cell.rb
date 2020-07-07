require './lib/ship'
require 'pry'

class Cell

  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
    @ship = nil
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)

  end

  def fire_upon

  end

  def fired_upon?

  end

  def render(truth) #if truth == true render ship as "S" instead of "."
# Prolly lots of conditionals here (maybe 5)
  end
end
