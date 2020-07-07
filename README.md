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

  <!-- Seems like the program doesn't work exactly like the real game so don't make assumptions haha-->
