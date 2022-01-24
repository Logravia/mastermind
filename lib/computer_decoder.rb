# frozen_string_literal: true

class ComputerDecoder
  extend ProcessCode

  NUM_FOR_COLOR = { 1 => 'RED', 2 => 'GREEN', 3 => 'BLUE', 4 => 'YELLOW', 5 => 'CYAN', 6 => 'PURPLE' }.freeze

  def initialize
    @possible_guesses = [1, 2, 3, 4, 5, 6].repeated_permutation(4).to_a
    @cur_guess = [1, 1, 2, 2]
    @guess_result = { perfect: nil, partial: nil }
  end

  def process_guess_result(result)
    @guess_result = result
    rm_impossible_guesses
    @cur_guess = possible_guesses.shift
  end

  # We remove all the guesses from possible guesses
  # that do not match with the our given guess
  # in the same way the SECRET CODE matched.
  def rm_impossible_guesses
    possible_guesses.select! do |guess|
      ProcessCode.match_result(guess, cur_guess) == [guess_result[:perfect], guess_result[:partial]]
    end
  end

  def guess
    to_colorcode(cur_guess)
  end

  # Guesses are stored as an array of Strings not numbers for readability and convinience
  def to_colorcode(code)
    code.map { |num| NUM_FOR_COLOR[num] }
  end

  private

  attr_accessor :unguessed_guesses, :possible_guesses, :guess_result, :first_guess, :cur_guess

  private_constant :NUM_FOR_COLOR
end
