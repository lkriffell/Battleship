class IntelligentFire

  attr_reader :array

  def initialize(who, letter, number)
    @player = who
    @letter = letter
    @number = number
    @array = []
  end

  def previous_letter
    # if letter - 1 exists => viable option
    return true if @player.board.letters.include?((@letter.ord - 1).chr.downcase)
    false
  end

  def next_letter
    # if letter + 1 exists => viable option
    return true if @player.board.letters.include?((@letter.ord + 1).chr.downcase)
    false
  end

  def right_number
    # if number to the right exists => viable option
    return true if @number + 1  <= @player.board.width
    false
  end

  def left_number
    # if number to the left exists => viable option
    return true if @number - 1  != 0
    false
  end

  def add_to_array

    # adds viable shooting options to the array if not fired upon previously

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

  def hit_comparison(hit_new, hit_old)
    return :horizontal if hit_new[0] == hit_old[0]
    return :vertical if hit_new[1] == hit_old[1]
  end

end
