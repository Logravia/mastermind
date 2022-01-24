# frozen_string_literal: true

module ProcessCode
  def self.match_result(guess, code)
    perfect_matches = 0
    # I don't want to modify original values as they will be used later on
    code = code.dup
    guess = guess.dup
    guess.each_with_index do |color, location|
      next unless code[location] == color

      perfect_matches += 1
      # Not removing perfect matches makes it impossible to find partial matches
      code[location] = nil
      guess[location] = nil
    end
    [perfect_matches, partial_matches(guess, code)]
  end

  def self.partial_matches(guess, code)
    partial_match_count = 0
    guess.each do |color|
      partial_match_place = code.find_index color
      next unless !partial_match_place.nil? && !color.nil?

      # When a partial match is found the pairs are removed,
      # so that you couldn't have a partial match again with the same element
      code[partial_match_place] = nil
      partial_match_count += 1
    end
    partial_match_count
  end
end
