require './lib/intelligent_fire'

class Turn

  attr_reader :player, :computer

  # used for testing
  #attr_reader :last_hit, :sub, :cru

  def initialize(player, computer)
    @player = player
    @computer = computer
    @last_hit = nil
    @sunk_ship_coord = nil

    # used for testing
    # @sub = nil
    # @cru = nil
  end #initialize

  def setup_board

    input = :incomplete
    until input == :complete
    print "\nWhat size board would you like (ex. 4x4, 10x10, max: 26x999)? "

      user_input = gets.chomp.split("x")

      height = user_input[0].to_i
      width = user_input[1].to_i

      if height > 26 || width > 999
        puts "\nPlease enter valid dimensions"
      else
        input = :complete
      end
    end

    player.board.set_board_size(height, width)
    computer.board.set_board_size(height, width)

    # returns length of board - not used by game
    # used for testing
    player.board.cells.length
  end #setup_board

  def player_setup_game

    puts "\nIt's time to place your ships! You have a Submarine which is two units long and a Cruiser which is three units long. When choosing it's location on the board, you cannot choose diagonal path or place a ship on top of another ship.\n\n"
    puts "=============YOUR BOARD============="
    # require "pry"; binding.pry
    puts print_board(player)

    ship_1_placement = :incomplete
    ship_2_placement = :incomplete

    #placement of submarine
    until ship_1_placement == :complete
      print "\nPlease enter the location for your Submarine (ex. A1 A2 or C4 D4): "
      user_input = gets.chomp.upcase.split

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
      user_input = gets.chomp.upcase.split

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

  end #player_setup_game

  def computer_setup_game
    ship_1_placement = :incomplete
    ship_2_placement = :incomplete

    #placement of submarine
    until ship_1_placement == :complete
      first_cell_pick = computer.board.cells.keys.sample(1)
      cell_picks = pick_next_cell(first_cell_pick)
      if computer.board.valid_coordinate?(cell_picks[0]) && computer.board.valid_coordinate?(cell_picks[1])
        if computer.board.valid_placement?(computer.ships[:submarine], [cell_picks[0],cell_picks[1]])
          computer.board.place(computer.ships[:submarine], [cell_picks[0],cell_picks[1]])

          # for testing purposes
          #@sub = [cell_picks[0],cell_picks[1]]

          ship_1_placement = :complete
        end
      end
    end # end of until loop

    #placement of cruiser
    until ship_2_placement == :complete
      first_cell_pick = computer.board.cells.keys.sample(1)
      cell_picks = pick_next_cell(first_cell_pick)
      cell_picks << pick_next_cell([cell_picks[1]])
      cell_picks = cell_picks.flatten!.uniq
      if computer.board.valid_coordinate?(cell_picks[0]) && computer.board.valid_coordinate?(cell_picks[1]) && computer.board.valid_coordinate?(cell_picks[2])
        if computer.board.valid_placement?(computer.ships[:cruiser], [cell_picks[0],cell_picks[1],cell_picks[2]])
          computer.board.place(computer.ships[:cruiser], [cell_picks[0],cell_picks[1],cell_picks[2]])

            # for testing purposes
            #@cru = [cell_picks[0],cell_picks[1],cell_picks[2]]

          ship_2_placement = :complete
        end
      end
    end # end of until loop

  end #computer_setup_game

  def pick_next_cell(previous_cell)
    split_up_coords = computer.board.split_coords(previous_cell).flatten!
    letter = split_up_coords[0]
    number = split_up_coords[1]
    # require "pry"; binding.pry
    # split_up_coords = split_up_coords.flatten!
    cells_to_sample = []
    if letter != computer.board.letters.first
      cells_to_sample << (letter.ord - 1).chr + number.to_s
    end
    if letter != computer.board.letters.last
      cells_to_sample << (letter.ord + 1).chr + number.to_s
    end
    if number != computer.board.width
      cells_to_sample << letter + (number.to_i + 1).to_s
    end
    if number != 1
      cells_to_sample << letter + (number.to_i - 1).to_s
    end
    next_cell = cells_to_sample.sample(1)
    if next_cell[0] > previous_cell[0]
      (previous_cell << next_cell).flatten!
    else
      (previous_cell.unshift(next_cell)).flatten!
    end
  end

  def game_setup
    # sets up board size
    setup_board

    # sets up ships for the player and computer
    computer_setup_game
    player_setup_game

  end #game_setup

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
        player_shot = gets.chomp.upcase
        if computer.board.valid_coordinate?(player_shot) && computer.board.cells[player_shot].has_been_fired_on == false
          shoot(computer, player_shot)
          break shot_successful = :success
        elsif computer.board.valid_coordinate?(player_shot) && computer.board.cells[player_shot].has_been_fired_on == true
          puts "Coordinate #{player_shot} has already been fired upon. Try again."
        else
          puts "Coordinate #{player_shot} is invalid. Try again."
        end
      end

      break if computer.has_lost?

      # COMPUTER SHOOT
      shot_successful = :fail

      until shot_successful == :success
        random_shot  = player.board.cells.values.sample(1)
        if @last_hit != nil
          intelligent_fire(@last_hit)
          shot_successful = :success
        elsif random_shot[0].has_been_fired_on == true
          # coordinate has been fired upon return to beginning of loop
        elsif random_shot[0].has_been_fired_on == false
          shoot(player, random_shot[0].coordinates)
          shot_successful = :success
        end
      end
    end # end of until loop

    # display winner message to winner
    if player.has_lost?
      display_winner(computer)
    else
      display_winner(player)
    end

  end #play_game

  def shoot(who, coords)
      who.board.cells[coords].fire_upon
      puts display_shot_results(who, coords)
  end #shoot

  def display_shot_results(who, player_shot)
    statement = nil

    if who == computer && who.board.cells.fetch(player_shot).ship == nil
        statement = "\nYour shot on #{player_shot} was a miss."
    elsif who == computer && who.board.cells.fetch(player_shot).ship != nil && who.board.cells.fetch(player_shot).ship.sunk?
        statement = "\nYour shot on #{player_shot} sunk a ship!"
    elsif who == computer && who.board.cells.fetch(player_shot).ship != nil
        statement = "\nYour shot on #{player_shot} was a hit!"
    elsif who == player && who.board.cells.fetch(player_shot).ship == nil
        statement = "\n#{computer.name}'s shot on #{player_shot} was a miss."
    elsif who == player && who.board.cells.fetch(player_shot).ship != nil && who.board.cells.fetch(player_shot).ship.sunk?
        @sunk_ship_coord = @last_hit
        @last_hit = nil
        statement = "\n#{computer.name}'s shot on #{player_shot} sunk a ship!"
    elsif who == player && who.board.cells.fetch(player_shot).ship != nil
        @last_hit = player_shot
        statement = "\n#{computer.name}'s shot on #{player_shot} was a hit!"
    end

    statement
  end #display_shot_results

  def print_board(who, conditional = false)
      return who.board.render if conditional == false
      return who.board.render(true)if conditional == true
  end #print_board

  def display_winner(winner)
    return puts "\nCongratulations! You won Battleship!\n\n" if winner == player
    return puts "\nYou lost all your ships! Computer won.\n\n" if winner == computer
  end #display_winner

  def intelligent_fire(last_hit_coordinate)

    mediator = last_hit_coordinate.split("")
    letter = mediator[0]
    number = mediator[1].to_i

    viable_options = IntelligentFire.new(player, letter, number)

    # clears left overs stored in array after sinking a ship
    if @sunk_ship_coord != last_hit_coordinate
      viable_options.clear_array
    end

    # adds viable firing options to array
    viable_options.add_to_array

    # takes sample from viable options array
    educated_shot = viable_options.array.sample

    # shoots at whichever viable option was chosen from above
    if educated_shot == 1
      shoot(player, ((letter.ord - 1).chr) + number.to_s)
      viable_options.remove_from_array(1)
    elsif educated_shot == 2
      shoot(player, ((letter.ord + 1).chr) + number.to_s)
      viable_options.remove_from_array(2)
    elsif educated_shot == 3
      shoot(player, letter + (number + 1).to_s)
      viable_options.remove_from_array(3)
    elsif educated_shot == 4
      shoot(player, letter + (number - 1).to_s)
      viable_options.remove_from_array(4)
    end


  end #intelligent_fire


end
