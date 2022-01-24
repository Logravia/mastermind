# frozen_string_literal: true

require 'pry-byebug'
require_relative 'coder_helper'
require_relative 'input_helper'

# Manages input from player to construct a code
class Player
  include CoderHelper
  extend InputHelper

  ACCEPTABLE_CHOICES = /[1-4][RGBYCP](?=\s)/

  LETTER_COLOR = { R: 'RED', G: 'GREEN', B: 'BLUE', Y: 'YELLOW', C: 'CYAN', P: 'PURPLE' }.freeze

  MIN_CHOICE = 1
  MAX_CHOICE = 4

  def initialize(role = 'decoder')
    @cur_guess = Array.new(4)
    @display = Display.new
    if role == 'coder'
      coder_msg
      guess
      @code_to_break = @cur_guess
    end
  end


  def process_guess_result(_argument)
    nil
  end

  def guess
    display.choices
    reset_guess
    loop do
      save_choices(InputHelper.get_choices(ACCEPTABLE_CHOICES))
      break if cur_guess.none? nil
    end
    cur_guess
  end

  private

  def coder_msg
    puts "Bad choice.\nTime to construct a code the computer will break in a second."

    puts 'Here are the rules: '
    puts 'There are 6 colors to choose from:'
    puts '[R]ed, [G]reen, [B]lue, [Y]ellow, [C]yan, [P]urple'
    puts 'You can place these colors in any one of four squares'
    puts '[1] [2] [3] [4]'
    puts 'Each square must have a color'
    puts 'Choose the square and the color like this: 1R'
    puts 'Or like this: 1Y 2B 3G 4R'
    puts 'Or like this 1B 4G 2Y, I don\'t care. Just give me the number and the color.'
  end

  # Turns raw String input into [location_int, :color_letter]
  def format_choice(choice)
    location = choice[0].to_i
    letter_sym = choice[1].to_sym
    [location, letter_sym]
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

  private_constant :LETTER_COLOR, :MIN_CHOICE, :MAX_CHOICE, :ACCEPTABLE_CHOICES
  attr_accessor :cur_guess
  attr_reader :code_to_break, :display
end
