# frozen_string_literal: true

require 'pry-byebug'

# Manages input from player to construct a code
class PlayerDecoder
  LETTER_COLOR = { R: 'RED', G: 'GREEN', B: 'BLUE', Y: 'YELLOW', C: 'CYAN', P: 'PURPLE' }.freeze
  MIN_CHOICE = 1
  MAX_CHOICE = 4

  def initialize
    @cur_guess = Array.new(4)
  end

  def guess
    reset_guess
    loop do
      save_choices(get_choices)
      break if cur_guess.none? nil
    end
    cur_guess
  end

  private

  def bad_input_msg
    puts 'Seems like your input was invalid. Try again or press q to quit.'
  end

  # Turns raw String input into [location_int, :color_letter]
  def format_choice(choice)
    location = choice[0].to_i
    letter_sym = choice[1].to_sym
    [location, letter_sym]
  end

  def get_choices()
    print "> "
    input = gets
    exit if input == "q\n"
    # Pattern gets you 1R, but only if whitespace follows it
    pattern = /[1-4][RGBYOP](?=\s)/
    choices = input.scan(pattern)
    bad_input_msg if choices.length == 0
    choices
  end

  def save_choices(choices)
    choices[0...4].each do |choice|
     save(format_choice(choice))
    end
  end

  def save(choice)
    location, letter = choice
    cur_guess[location - 1] = LETTER_COLOR[letter]
  end

  def reset_guess
    cur_guess.map! { nil }
  end

  private_constant :LETTER_COLOR, :MIN_CHOICE, :MAX_CHOICE
  attr_writer :cur_guess
  attr_reader :cur_guess
end
