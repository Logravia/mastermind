# frozen_string_literal: true

require_relative 'code_constructor'
require_relative 'coder'
require_relative 'decoder'
require_relative 'screen'

# Manages the game loop
# Holds history of Decoders choices
class Game
  def initialize
    @history = {} # Guesses and hints
    @coder = Coder.new
    @decoder = Decoder.new
    @screen = Screen.new
    @round_count = 12
  end

  def play
    round_count.times do
    end
  end
end
