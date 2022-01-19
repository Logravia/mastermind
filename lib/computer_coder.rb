# frozen_string_literal: true
require 'pry-byebug'
# Manages creation of a random color code, checking it against player's guess and giving hints based on the guess
class ComputerCoder
  NUM_FOR_COLOR = { 1 => 'RED', 2 => 'GREEN', 3 => 'BLUE', 4 => 'YELLOW', 5 => 'ORANGE', 6 => 'PURPLE' }.freeze
  MIN_COLOR = 1
  MAX_COLOR = 6
  def initialize
    @code_to_break = random_code
  end

  def matches(guess)
    perfect_matches = 0
    guess.each_with_index do |color, location|
      if code_to_break[location] == color
        perfect_matches += 1
      end
    end
    perfect_matches
  end

  # All perfect matches are also partial matches
  # Have to remove them so that we get accurate count
  def no_perfect_matches(guess)
    guess.each_with_index do |color, location|
      if code_to_break[location] == color
        guess[location] = nil
      end
    end
    guess
  end

  def count_colors(code)
    color_count = {}
    code.each do |color|
      next if color.nil?
      if not color_count.key? color
        color_count[color] = 1
      else
        color_count[color] += 1
      end
    end
    color_count
  end

  # Method compares color count of code_to_break and guess
  # When both codes have 2 reds, there are 2 partial matches
  # When guess has 1 red and code has 2 reds, there's 1 partial match
  # When guess has 2 reds and code 1 red there's 1 match
  #
  # This works since all perfect matches are removed
  def partial_matches(guess)
    partial_match_count = 0
    guess = no_perfect_matches(guess)
    code_counted = count_colors(code_to_break)
    guess_counted = count_colors(guess)

    guess_counted.each do |color, count|
      if code_counted.key? color
        if code_counted[color] < guess_counted[color]
          partial_match_count += code_counted[color]
        else
          partial_match_count += count
        end
      end
    end
    partial_match_count
  end

  def give_hints(guess)
    {perfect: matches(guess), partial: partial_matches(guess)}
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
