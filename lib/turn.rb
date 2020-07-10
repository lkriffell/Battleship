class Turn

  attr_reader :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer

    # used for testing
    # @sub = nil
    # @cru = nil
  end # end of initialize

  def shoot(who, coords)
      who.board.cells[coords].fire_upon
      display_shot_results(who, coords)
  end # end of shoot

  def main_menu
    exit_condition = false

    until exit_condition == true
      puts "===================================="
      puts "Welcome to BATTLESHIP"
      puts "Enter p to play. Enter q to quit."
      puts "===================================="

      user_input = gets.chomp.downcase
      if user_input == 'p'
        computer_setup_game
        player_setup_game
        play_game
      elsif user_input == 'q'
        puts "Thanks for playing! Come again."
        exit_condition = true
        break
      else
        puts "Oops! Please enter a valid option."
      end
    end # end of until loop
  end # end of main_menu

  def play_game
    until player.has_lost? || computer.has_lost?

      # display_the_boards
      puts "\n=============COMPUTER BOARD============="
      puts print_board(computer)
      puts "==============YOUR BOARD=============="
      puts print_board(player, true)

      # PLAYER SHOOT
      shot_successful = :fail

      until shot_successful == :success
        print "\nEnter the coordinate for your shot: "
        player_shot = gets.chomp
        if computer.board.valid_coordinate?(player_shot) && computer.board.cells[player_shot].has_been_fired_on == false
          shoot(computer, player_shot)
          break shot_successful = :success
        elsif computer.board.valid_coordinate?(player_shot) && computer.board.cells[player_shot].has_been_fired_on == true
          puts "Coordinate #{player_shot} has already been fired upon. Try again."
        elsif !computer.board.valid_coordinate?(player_shot) && computer.board.cells[player_shot].has_been_fired_on == false
          puts "Coordinate #{player_shot} is invalid. Try again."
        else
          puts "Invalid input. Try again."
        end
      end

      # COMPUTER SHOOT
      shot_successful = :fail

      until shot_successful == :success
        random_shot  = player.board.cells.values.sample(1)
        if random_shot[0].has_been_fired_on == true
          # coordinate has been fired upon return to beginning of loop
        elsif random_shot[0].has_been_fired_on == false
          shoot(player, random_shot[0].coordinates)
          shot_successful = :success
        end
      end


      # fired_upon = :unknown
      # while fired_upon == :unknown
      #   computer_shot = player.board.cells.values.sample(1)
      #   if computer_shot[0].has_been_fired_on != true
      #     fired_upon = :not_yet
      #   end
      #   shoot(player, computer_shot[0].coordinates)
      # end

    end # end of until loop

    # display winner message to winner
    if player.has_lost?
      display_winner(computer)
    else
      display_winner(player)
    end

  end # end of play_game

  def display_shot_results(who, player_shot)
    if who == computer && who.board.cells.fetch(player_shot).ship == nil
        puts "\nYour shot on #{player_shot} was a miss."
    elsif who == computer && who.board.cells.fetch(player_shot).ship != nil && who.board.cells.fetch(player_shot).ship.sunk?
        puts "\nYour shot on #{player_shot} sunk a ship!"
    elsif who == computer && who.board.cells.fetch(player_shot).ship != nil
        puts "\nYour shot on #{player_shot} was a hit!"
    elsif who == player && who.board.cells.fetch(player_shot).ship == nil
        puts "\n#{computer.name} shot on #{player_shot} was a miss."
    elsif who == player && who.board.cells.fetch(player_shot).ship != nil && who.board.cells.fetch(player_shot).ship.sunk?
        puts "\n#{computer.name} shot on #{player_shot} sunk a ship!"
    elsif who == player && who.board.cells.fetch(player_shot).ship != nil
        puts "\n#{computer.name} shot on #{player_shot} was a hit!"
    end
  end # end of display_shot_results

  def print_board(who, conditional = false)
    if conditional == false
      return who.board.render
    else
      return who.board.render(true)
    end
  end # end of print_board

  def display_winner(winner)
    puts "\nCongratulations! #{winner.name} won Battleship!\n"
  end # end of display_winner

  def player_setup_game

    puts "\n\nIt's time to place your ships! You have a Submarine which is two units long and a Cruiser which is three units long. When choosing it's location on the board, you cannot choose diagonal path or place a ship on top of another ship.\n\n"
    puts "=============YOUR BOARD============="
    puts print_board(player)

    ship_1_placement = :incomplete
    ship_2_placement = :incomplete

    #placement of submarine
    until ship_1_placement == :complete
      print "\nPlease enter the location for your Submarine (ex. A1 A2 or C4 D4): "
      user_input = gets.chomp.split

      if player.board.valid_coordinate?(user_input[0]) && player.board.valid_coordinate?(user_input[1])
        if player.board.valid_placement?(player.ships[:submarine], [user_input[0],user_input[1]])
          puts "\nExcellent spot! You placed your Submarine at #{user_input[0]} and #{user_input[1]}.\n"
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
          puts "\nExcellent spot! You placed your Cruiser at #{user_input[0]}, #{user_input[1]} and #{user_input[2]}.\n"
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

  end # end of player_setup_game

  def computer_setup_game
    ship_1_placement = :incomplete
    ship_2_placement = :incomplete

    #placement of submarine
    until ship_1_placement == :complete
      rand_cells_1 = computer.board.cells.keys.sample(2)
      if computer.board.valid_coordinate?(rand_cells_1[0]) && computer.board.valid_coordinate?(rand_cells_1[1])
        if computer.board.valid_placement?(computer.ships[:submarine], [rand_cells_1[0],rand_cells_1[1]])
          computer.board.place(computer.ships[:submarine], [rand_cells_1[0],rand_cells_1[1]])

          # for testing purposes
          #@sub = [rand_cells_1[0],rand_cells_1[1]]

          ship_1_placement = :complete
        end
      end
    end # end of until loop

    #placement of cruiser
    until ship_2_placement == :complete
      rand_cells_2 = computer.board.cells.keys.sample(3)
      if computer.board.valid_coordinate?(rand_cells_2[0]) && computer.board.valid_coordinate?(rand_cells_2[1]) && computer.board.valid_coordinate?(rand_cells_2[2])
        if computer.board.valid_placement?(computer.ships[:cruiser], [rand_cells_2[0],rand_cells_2[1],rand_cells_2[2]])
          computer.board.place(computer.ships[:cruiser], [rand_cells_2[0],rand_cells_2[1],rand_cells_2[2]])
          # p "Computer's board"
          # puts print_board(computer, true)

            # for testing purposes
            #@cru = [rand_cells_2[0],rand_cells_2[1],rand_cells_2[2]]

          ship_2_placement = :complete
        end
      end
    end # end of until loop

  end # end of computer_setup_game

end
