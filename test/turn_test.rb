require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'
require './lib/turn'

class TurnTest < Minitest::Test

  def test_a_turn_exists
    skip
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    assert_instance_of Turn, turn
  end

  def test_players_can_shoot
    skip
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    turn.player.board.place(player_ships[:submarine], ["A1", "A2"])

    turn.shoot(player, "A1")

    assert_equal 1, player_ships[:submarine].health
  end

  def test_print_board
    skip
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    turn.player.board.place(player_ships[:submarine], ["A1", "A2"])
    turn.player.board.place(player_ships[:cruiser], ["A4", "B4", "C4"])

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . .", turn.print_board(player)
    assert_equal "  1 2 3 4 \nA S S . S \nB . . . S \nC . . . S \nD . . . .", turn.print_board(player, true)

  end

  def test_game_setup_for_player
    # => manual test as requires input
    skip # please read assert before removing skip
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    turn.player_setup_game # => requires manual input

    # => adjust test for whatever input you are going to use
    # => current test for sub at B3 B4 and cruiser at B1 C1 D1
    assert_equal ("  1 2 3 4 \nA . . . . \nB S . S S \nC S . . . \nD S . . ."), turn.print_board(player, true)

  end

  def test_game_setup_for_computer
    # OPTIMIZE: Refactor code as to not need global variabls to pass test
    skip # => UN-comment code in turn.rb such as @sub @cru and related code
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    turn.computer_setup_game

    refute turn.computer.board.valid_placement?(turn.computer.ships[:submarine], turn.sub)
    refute turn.computer.board.valid_placement?(turn.computer.ships[:cruiser], turn.cru)
  end

  def test_board_setup
    skip
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    assert_equal player.board.cells.length, turn.setup_board
  end

  def test_display_shot_results
    skip
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "Computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)

    assert_equal "\nComputer shot on A1 was a miss.", turn.display_shot_results(player, "A1")

    turn.player.board.place(player_ships[:submarine], ["A1", "A2"])

    assert_equal "\nComputer shot on A1 was a hit!", turn.display_shot_results(player, "A1")
  end

  def test_intelligent_fire
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "Computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    turn.intelligent_fire("B3")
  end


end
