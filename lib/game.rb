# frozen_string_literal: true
require_relative 'input_helper'

class Game
  extend InputHelper
  LAST_ROUND = 12
  attr_reader :coder, :guesser, :display
  attr_accessor :cur_guess, :history, :round

  private_constant :LAST_ROUND
  def initialize
    @coder = nil
    @guesser = nil
    @display = Display.new
    @history = {}
    @cur_guess = []
    @cur_hint = {}
    @round = 0
  end

  def play
    until round == LAST_ROUND
      cur_guess = guesser.guess
      cur_hint = coder.hint(cur_guess)

      guesser.process_guess_result(cur_hint)

      save_result(cur_guess, cur_hint, round)

      display.clear
      display.history(history)

      victory if coder.perfect_guess? cur_guess
      @round += 1
    end
    loss
  end

  def your_role?
    role_msg
    role = InputHelper.get_choices(/(?<!.)[1-3][\n]/).join.chomp.to_i
    if role == 1
      @coder = Player.new("coder")
      @guesser = ComputerDecoder.new
      binding.pry
    elsif role == 2
      @coder = ComputerCoder.new
      @guesser = Player.new("decoder")
    else
      @coder = ComputerCoder.new
      @guesser = ComputerDecoder.new
    end
    display.clear
  end

  private

  def role_msg
    puts '+--------------------------------------------------------------+'
    puts '[1] Would you like to make a code that the computer will break?'
    puts '+--------------------------------------------------------------+'
    puts '[2] Or would you like to try to break the computer\'s code?'
    puts '+--------------------------------------------------------------+'
    puts '[3] Alternatively, sit back and watch two computers battle it out?'
    puts '+--------------------------------------------------------------+'
  end


  def victory
    puts 'Last guess was the correct one.'
    exit!
  end

  def loss
    puts 'Sorry, none of the guesses were right.'
    exit
  end

  def save_result(guess, hint, round)
    history[{ guess: guess.dup, round: round }] = hint
  end
end
