# frozen_string_literal: true

class Game
  LAST_ROUND = 12
  attr_reader :coder, :guesser
  attr_accessor :cur_guess, :history, :round
  private_constant :LAST_ROUND
  def initialize
    @coder = ComputerCoder.new
    @guesser = PlayerDecoder.new
    @history = {}
    @cur_guess = []
    @cur_hint = {}
    @round = 0
  end

  def play
    until round == LAST_ROUND
      cur_guess  = guesser.guess
      cur_hint = coder.hint(cur_guess)

      victory if coder.perfect_guess? cur_guess

      save_result(cur_guess, cur_hint, round)
      @round += 1
      pp history
    end
  end

  private

  def victory
    puts "YOU WON!"
    puts "#{cur_guess} was the correct one!"
  end

  def save_result(guess, hint, round)
    history[{guess: guess.dup, round: round}] = hint
  end


end
