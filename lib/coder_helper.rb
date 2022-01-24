# frozen_string_literal: true

require_relative 'process_code'

# Allows the player and the computer to give hints and tell whether the  guess was perfect
module CoderHelper
  # Heavy lifting of processing the code is done in ProcessCode
  extend ProcessCode

  def hint(guess)
    result = ProcessCode.match_result(guess, code_to_break)
    { perfect: result[0], partial: result[1] }
  end

  def perfect_guess?(guess)
    guess == code_to_break
  end
end
