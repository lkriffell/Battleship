class Player
  attr_reader :board, :ships, :name
  def initialize(board, ships, name)
    @board = board
    @ships = ships
    @name = name

  end
end
