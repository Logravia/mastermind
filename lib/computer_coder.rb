# frozen_string_literal: true

require 'pry-byebug'
require_relative 'process_code'
# Manages creation of a random color code, checking it against player's guess and giving hint based on the guess
class ComputerCoder
  NUM_FOR_COLOR = { 1 => 'RED', 2 => 'GREEN', 3 => 'BLUE', 4 => 'YELLOW', 5 => 'CYAN', 6 => 'PURPLE' }.freeze
  MIN_COLOR = 1
  MAX_COLOR = 6
  def initialize
    @code_to_break = random_code
  end

  extend ProcessCode

  def hint(guess)
    { perfect: ProcessCode.matches(guess, code_to_break), partial: ProcessCode.partial_matches(guess, code_to_break) }
  end

  def perfect_guess?(guess)
    guess == code_to_break
  end

  private

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
