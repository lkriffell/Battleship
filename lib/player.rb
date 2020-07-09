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

  def main_menu
    # Return here when a game ends
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    play = gets.chomp
      if play == 'p'

      elsif play != 'q'
        main_menu #Hopefully this returns the user to the main menu
      end
  end
end
