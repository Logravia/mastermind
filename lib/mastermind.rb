# frozen_string_literal: true

require_relative 'mastermind/version'

module Mastermind
  # Manages the game loop
  # Holds history of Decoders choices
  class GameManager
    def initialize
      @history = {} # Guesses and hints
      @coder = Coder.new
      @decoder = Decoder.new
      @scrn = Screen.new
      @round_count = 12
    end

    def play
      round_count.times do
      end
    end
  end

  # Constructs a valid code (the_code) to decode
  # Gives hints on how close you are to guess the_code
  # Checks whether your code matches to the_code
  class Coder
    def initialize
      @the_code = []
      @is_set = false
    end

    def the_code=(code)
      @the_code = code unless is_set
    end

    def give_hint(code)
      # TODO: compare given code to the_code
      # Give hint
    end

    def match?(code)
      code == the_code
    end

    private

    attr_accessor :set
  end

  # Constructs valid guess to send to the Coder
  class Decoder
    attr_reader :cur_guess

    def initialize
      @cur_guess = []
    end

    def construct_guess
      # TODO: Code to construct a valid array containing 4 colors.
    end
  end

  # Manages how things are displayed, e.g. how to display history of choices
  class Screen
    def show_hist
      # TODO: Show the whole history of choices and hints in a pretty format
    end
  end

  # Helps constructing valid code for Coder/Decoder
  module CodeConstructor
    @colors = { 1 => 'Color' }
    def prompt
      # TODO: get input from AI or player
      # Check whether it is legal choice
    end

    def make_code
      # TODO: Make the code from legal inputs from the prompt
      # Return legal code
    end
  end
end
