# frozen_string_literal: true

require 'pry-byebug'

# Manages input from player to construct a code
class PlayerDecoder
  LETTER_COLOR = { R: 'RED', G: 'GREEN', B: 'BLUE', Y: 'YELLOW', O: 'ORANGE', P: 'PURPLE' }.freeze
  MIN_CHOICE = 1
  MAX_CHOICE = 4

  def initialize
    @cur_guess = Array.new(4)
  end

  def guess
    reset_guess
    loop do
      save(format_choice(location_letter))
      break if cur_guess.none? nil
    end
    cur_guess
  end

  private

  def bad_input_msg
    puts 'Sorry, bad input. Try again or press q to quit.'
  end

  # Turns raw String input into [location_int, :color_letter]
  def format_choice(choice)
    location = choice[0].to_i
    letter_sym = choice[1].to_sym
    [location, letter_sym]
  end

  # Gets location and letter of the color from player
  def location_letter
    print 'Please input location and color: '
    choice = gets.chomp
    exit if choice == 'q'
    until valid_input?(choice)
      bad_input_msg
      choice = location_letter
    end
    choice
  end

  def valid_input?(choice)
    return false if choice.chars.length != 2

    location, letter = format_choice(choice)
    location.between?(MIN_CHOICE, MAX_CHOICE) and LETTER_COLOR.key? letter
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
