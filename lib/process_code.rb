# frozen_string_literal: true

module ProcessCode
  def self.matches(guess, code)
    perfect_matches = 0
    guess.each_with_index do |color, location|
      perfect_matches += 1 if code[location] == color
    end
    perfect_matches
  end

  # All perfect matches can also be partial matches
  # Thus muddying waters for an algorithm trying to find only partial matches
  # Returns modified array of the two given arrays
  # Each element with the same value and index
  # Is replaced with nil, in other words perfect matches are removed
  def self.no_perfect_matches(guess, code)
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

  # Partial
  def self.partial_matches(guess, code)
    partial_match_count = 0
    guess, code = no_perfect_matches(guess, code)
    guess.each do |color|
      next unless code.include?(color) && !color.nil?

      index_to_remove = code.find_index color
      # When a partial match is found the pairs are removed,
      # so that you couldn't have a partial match again with that color
      # One pair is "removed" by incrementing to next element
      # The other by declaring it nil
      code[index_to_remove] = nil
      partial_match_count += 1
    end
    partial_match_count
  end
end
