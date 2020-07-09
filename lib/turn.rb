class Turn

  attr_reader :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def shoot(who, coords)
    who.board.cells[coords].fire_upon
  end

  def main_menu
    puts "===================================="
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    puts "===================================="

    user_input = gets.chomp.to_downcase

    exit_condition = false

    until exit_condition == true
      if user_input == 'p'
        #TODO
      elsif user_input == 'q'
        exit_condition = true
        break
      else
        puts "Oops! Please enter a valid option."
      end
    end
  end

  def print_board(who, conditional = false)
    if conditional == false
      return who.board.render
    else
      return who.board.render(true)
    end
  end

  def player_setup_game
    puts print_board(player)
    puts "\nYou have a Submarine which is two units long and a Cruiser which is three units long."
    puts "When choosing it's location on the board, you cannot choose diagonal path or place a ship on top of another ship.\n\n"

    ship_1_placement = :incomplete
    ship_2_placement = :incomplete

    #placement of submarine
    until ship_1_placement == :complete
      print "Please enter the location for your Submarine (ex. A1 A2 or C4 D4): "
      user_input = gets.chomp.split

      if player.board.valid_coordinate?(user_input[0]) && player.board.valid_coordinate?(user_input[1])
        if player.board.valid_placement?(player.ships[:submarine], [user_input[0],user_input[1]])
          puts "\nExcellent spot! You placed your Submarine here:\n"
          player.board.place(player.ships[:submarine], [user_input[0],user_input[1]])
          puts print_board(player, true)
          ship_1_placement = :complete
        else
          puts "Placement is invalid. Try again."
        end
      else
        puts "Coordinate is invalid. Try again."
      end
    end

    #placement of cruiser
    until ship_2_placement == :complete
      print "\nPlease enter the location for your Cruiser (ex. A1 A2 A3 or B2 C2 D2): "
      user_input = gets.chomp.split

      if player.board.valid_coordinate?(user_input[0]) && player.board.valid_coordinate?(user_input[1]) && player.board.valid_coordinate?(user_input[2])
        if player.board.valid_placement?(player.ships[:cruiser], [user_input[0], user_input[1], user_input[2]]) == true
          puts "\nExcellent spot! You placed your Cruiser here:\n"
          player.board.place(player.ships[:cruiser], [user_input[0],user_input[1],user_input[2]])
          puts print_board(player, true)
          ship_2_placement = :complete
        else
          puts "Placement is invalid. Try again."
        end
      else
        puts "Coordinate is invalid. Try again."
      end
    end

  end #end of setup method

  def computer_setup_game

  end
end
