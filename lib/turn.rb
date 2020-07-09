class Turn

  attr_reader :player, :computer
  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def shoot(coords)
    coords.fire_upon
  end
end
