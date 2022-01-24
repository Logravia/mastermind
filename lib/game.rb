# frozen_string_literal: true

class Game
  LAST_ROUND = 12
  attr_reader :coder, :guesser, :display
  attr_accessor :cur_guess, :history, :round

  private_constant :LAST_ROUND
  def initialize
    @coder = PlayerCoder.new
    @guesser = ComputerDecoder.new
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
  end

  private

  def victory
    puts 'YOU WON!'
    puts 'Last guess was the correct one!'
    exit
  end

  def save_result(guess, hint, round)
    history[{ guess: guess.dup, round: round }] = hint
  end
end
