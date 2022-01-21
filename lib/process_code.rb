module ProcessCode
  def ProcessCode.matches(guess, code)
    perfect_matches = 0
    guess.each_with_index do |color, location|
      perfect_matches += 1 if code[location] == color
    end
    perfect_matches
  end

  # All perfect matches can also be partial matches
  # Thus muddying waters for an algorithm trying to find only partial matches
  # Returns modified array of the two given arrays
  # Each element that was the same and at the same location in both arrays
  # Is replaced with nil, in other words perfect matches are removed
  def ProcessCode.no_perfect_matches(guess, code)
    guess = guess.dup
    code = code.dup
    guess.each_with_index do |color, location|
      if code[location] == color
        guess[location] = nil
        code[location] = nil
      end
    end
    [guess, code]
  end

  def ProcessCode.partial_matches(guess, code)
    partial_match_count = 0
    guess, code = no_perfect_matches(guess, code)
    guess.each do |color|
      next unless code.include?(color) && !color.nil?

      index_to_remove = code.find_index color
      code[index_to_remove] = nil
      partial_match_count += 1
    end
    partial_match_count
  end
end
