require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/player'
require './lib/turn'
require './lib/intelligent_fire'

class TestIntelligentFire < Minitest::Test
  def test_it_exists
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    fire = IntelligentFire.new(player, "C", 3)

    assert_instance_of IntelligentFire, fire
  end

  def test_previous_letter
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    fire = IntelligentFire.new(player, "C", 3)

    assert_equal true, fire.previous_letter

    fire = IntelligentFire.new(player, "A", 3)

    assert_equal false, fire.previous_letter
  end

  def test_next_letter
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    fire = IntelligentFire.new(player, "C", 3)

    assert_equal true, fire.next_letter

    fire = IntelligentFire.new(player, "D", 3)

    assert_equal false, fire.next_letter
  end

  def test_right_number
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    fire = IntelligentFire.new(player, "C", 3)

    assert_equal true, fire.right_number

    fire = IntelligentFire.new(player, "C", 4)

    assert_equal false, fire.right_number
  end

  def test_left_number
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    fire = IntelligentFire.new(player, "C", 3)

    assert_equal true, fire.left_number

    fire = IntelligentFire.new(player, "C", 1)

    assert_equal false, fire.left_number
  end

  def test_can_add_to_array
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    fire = IntelligentFire.new(player, "C", 3)

    assert_equal [1, 2, 3, 4], fire.add_to_array
  end

  def test_can_remove_from_array
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    fire = IntelligentFire.new(player, "C", 3)

    fire.add_to_array

    assert_equal 3, fire.remove_from_array(3)
  end

  def test_can_clear_array
    player_board = Board.new
    player_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    player = Player.new(player_board, player_ships, "player")

    computer_board = Board.new
    computer_ships = {:submarine => Ship.new("submarine", 2), :cruiser => Ship.new("Cruiser", 3)}
    computer = Player.new(computer_board, computer_ships, "computer")
    turn = Turn.new(player, computer)

    turn.player.board.set_board_size(4, 4)
    turn.computer.board.set_board_size(4, 4)

    fire = IntelligentFire.new(player, "C", 3)

    fire.add_to_array

    assert_equal [], fire.clear_array
  end
end
