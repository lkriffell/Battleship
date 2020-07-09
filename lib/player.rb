class Player
  attr_reader :board, :ships, :name
  def initialize(board, ships, name)
    @board = board
    @ships = ships
    @name = name
  end

  def has_lost?
    if ships[:submarine].sunk? == true && ships[:cruiser].sunk? == true
      true
    end
  end
end
