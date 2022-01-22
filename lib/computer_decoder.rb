require_relative 'process_code'
require 'pry-byebug'

class ComputerDecoder
  NUM_FOR_COLOR = { 1 => 'RED', 2 => 'GREEN', 3 => 'BLUE', 4 => 'YELLOW', 5 => 'CYAN', 6 => 'PURPLE' }.freeze
  extend ProcessCode
  def initialize
    @unguessed_guesses = [*1111..6666].map! { |num| split_num_into_arr(num) }
    @possible_guesses = [*1111..6666].map! { |num| split_num_into_arr(num) }
    @cur_guess = [1,1,2,2]
    @guess_result = {perfect: nil, partial: nil}
  end

  def save_guess_result(result)
    @guess_result = result
    rm_impossible_guesses
    rm_guessed_guess
    find_next_guess
  end


  def find_next_guess
    guess_scores = {}
    unguessed_guesses.each do |unguessed|
      guess_scores[unguessed] = {}
      possible_guesses.each do |possible|
        match_result = get_match_result_arr(unguessed, possible)
        if guess_scores[unguessed].key? match_result
          guess_scores[unguessed][match_result] += 1
        else
          guess_scores[unguessed][match_result] = 1
        end
      end
    end
    binding.pry
    guess_scores
  end

  def get_match_result(code_one, code_two)
    {perfect: ProcessCode.matches(code_one, code_two),
      partial: ProcessCode.partial_matches(code_one, code_two)}
  end

  def get_match_result_arr(code_one, code_two)
    [ProcessCode.matches(code_one, code_two), ProcessCode.partial_matches(code_one, code_two)]
  end

  # We remove all the guesses from possible guesses
  # that do not match with the OUR GIVEN GUESS
  # in the same way the SECRET CODE we are trying to break matched
  def rm_impossible_guesses
    possible_guesses.reject! do |guess|
      match_result = get_match_result(guess, cur_guess)
      guess_result == match_result
    end
  end

  def rm_guessed_guess
    delete_this = unguessed_guesses.find_index(cur_guess)
    unguessed_guesses.delete_at(delete_this)
  end

  def guess
      to_colorcode(cur_guess)
  end

  def split_num_into_arr(num)
    num.to_s.chars.map! { |char| char.to_i }
  end

  # Guesses are stored as an array of Strings not numbers for readability and convinience
  def to_colorcode(code)
    code.map {|num| NUM_FOR_COLOR[num]}
  end

  private
  attr_accessor :unguessed_guesses, :possible_guesses, :guess_result, :first_guess, :cur_guess
  private_constant :NUM_FOR_COLOR
end
