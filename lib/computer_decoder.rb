require_relative 'process_code'
class ComputerDecoder
  NUM_FOR_COLOR = { 1 => 'RED', 2 => 'GREEN', 3 => 'BLUE', 4 => 'YELLOW', 5 => 'CYAN', 6 => 'PURPLE' }.freeze
  public
  extend ProcessCode
  def initialize
    @unguessed_guesses = [*1111..6666]
    @possible_guesses = [*1111..6666]
    @first_guess = 1122
    @cur_guess = nil
    @guess_result = {perfect: nil, partial: nil}
  end

  def save_guess_result(result)
    @guess_result = result
  end

  def guess
    if unguessed_guesses == possible_guesses
      int_to_colorcode(first_guess)
    else
      int_to_colorcode(cur_guess)
    end
  end

  # Guesses are stored as an array of Strings not numbers for readability and convinience
  def int_to_colorcode(code)
    code.to_s.chars.map! {|char| NUM_FOR_COLOR[char.to_i]}
  end

  private
  attr_accessor :unguessed_guesses, :possible_guesses, :guess_result, :first_guess, :cur_guess
  private_constant :NUM_FOR_COLOR
end
