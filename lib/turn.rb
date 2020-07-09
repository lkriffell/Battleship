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

      elsif user_input == 'q'
        exit_condition = true
        break
      else
        puts "Oops! Please enter a valid option."
      end
    end
  end

  def method_name

  end

end
