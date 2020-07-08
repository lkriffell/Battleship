<!-- Ship comes before cells-->
class - ship(name, length)
<!-- @health = length -->
hit(if fired_upon? -> true),
sunk? true or false depending on health

class - Cell(coordinates -> ("G1"))
  Methods:
  empty? -> true or false
  place_ship(arg)
  fired_upon? -> true or false
  fire_upon
  render(optional arg) -> string of '.' , 'M', 'H', 'X'

possible classes
Turn class(player1, computer) <- not sure about this
methods:
  shoot(coordinate)
  main menu
  display_grid



Player class(board, ships, name("computer"))
methods:
  has_lost?

  welcome msg
    go
      display empty grid
      print sub and cruiser where place?

      computer chooses placement of ship

      user input - > place ship
        if placement - > place ship
        if placement bad -> error msg


      display grid

      msg to player to choose place to fire
        if player chooses coord where ship is -> hit
        if not then miss
        A shot missed
        A shot hit a ship
        or A shot sunk a ship
        msg for whatever happens

        display grid that shows where user attempted fire

        computer fires
          displays msg if hit or mis

        repeat from line 39


<!-- From Rubric -->
Project includes at least one additional class not outlined in the spec that
does no command line input or output, adheres to SRP, and acts as a crucial
piece in the function of the program

Setup:

Computer can place ships randomly in valid locations
User can enter valid sequences to place both ships
Entering invalid ship placements prompts user to enter valid placements

Turn:
User board is displayed showing hits, misses, sunken ships, and ships
Computer board is displayed showing hits, misses, and sunken ships
Computer chooses a random shot
Computer does not fire on the same spot twice
User can choose a valid coordinate to fire on
Entering invalid coordinate prompts user to enter valid coordinate
Both computer and player shots are reported as a hit, sink, or miss
User is informed when they have already fired on a coordinate
Board is updated after a turn

End Game:
Game ends when all the user’s ships are sunk
Game ends when all the computer’s ships are sunk
Game reports who won
Game returns user back to the Main Menu
