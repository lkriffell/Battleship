class IntelligentFire

  attr_reader :array

  def initialize(who, letter, number)
    @player = who
    @letter = letter
    @number = number
    @array = []
  end

  def previous_letter
    # if letter - 1 exists shoot there
    return true if @player.board.letters.include?((@letter.ord - 1).chr.downcase)
    false
  end

  def next_letter
    # if letter + 1 exists shoot there
    return true if @player.board.letters.include?((@letter.ord + 1).chr.downcase)
    false
  end

  def right_number
    # shoots to the right of the last_hit
    return true if @number + 1  <= @player.board.width
    false
  end

  def left_number
    # shoots to the left of the last_hit
    return true if @number - 1  != 0
    false
  end

  def add_to_array
    if previous_letter == true && (@player.board.cells[((@letter.ord - 1).chr) + @number.to_s].has_been_fired_on == false)
      @array << 1
    end
    if next_letter == true && (@player.board.cells[((@letter.ord + 1).chr) + @number.to_s].has_been_fired_on == false)
      @array << 2
    end
    if right_number == true && (@player.board.cells[@letter + ((@number + 1)).to_s].has_been_fired_on == false)
      @array << 3
    end
    if left_number == true && (@player.board.cells[@letter + ((@number - 1)).to_s].has_been_fired_on == false)
      @array << 4
    end

    array
  end

  def remove_from_array(num)
    @array.delete(num)
  end

  def clear_array
    @array.clear
  end

end
