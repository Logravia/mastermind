# frozen_string_literal: true

require 'pry-byebug'
# Manages creation of a random color code, checking it against player's guess and giving hint based on the guess
class ComputerCoder
  NUM_FOR_COLOR = { 1 => 'RED', 2 => 'GREEN', 3 => 'BLUE', 4 => 'YELLOW', 5 => 'CYAN', 6 => 'PURPLE' }.freeze
  MIN_COLOR = 1
  MAX_COLOR = 6
  def initialize
    @code_to_break = random_code
  end

  def hint(guess)
    { perfect: matches(guess), partial: partial_matches(guess) }
  end

  def perfect_guess?(guess)
    guess == code_to_break
  end

  private
  def matches(guess)
    perfect_matches = 0
    guess.each_with_index do |color, location|
      perfect_matches += 1 if code_to_break[location] == color
    end
    perfect_matches
  end

  # All perfect matches can also be partial matches
  # Thus muddying waters for an algorithm trying to find only partial matches
  # Returns modified array of the two given arrays
  # Each element that was the same and at the same location in both arrays
  # Is replaced with nil, in other words perfect matches are removed
  def no_perfect_matches(guess, code)
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

  def partial_matches(guess)
    partial_match_count = 0
    guess, code = no_perfect_matches(guess, code_to_break)
    guess.each do |color|
      next unless code.include?(color) && !color.nil?

      index_to_remove = code.find_index color
      code[index_to_remove] = nil
      partial_match_count += 1
    end
    partial_match_count
  end

  def random_code
    code = []
    until code.length == 4
      choice = rand(MIN_COLOR..MAX_COLOR)
      code << NUM_FOR_COLOR[choice]
    end
    code
  end

  attr_reader :code_to_break

  private_constant :NUM_FOR_COLOR, :MIN_COLOR, :MAX_COLOR
end
