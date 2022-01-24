# frozen_string_literal: true

require 'pry-byebug'
require_relative 'player_decoder'
require_relative 'computer_decoder'
require_relative 'computer_coder'
require_relative 'game'
require_relative 'display'
require_relative 'process_code'
require_relative 'coder_helper'

game = Game.new
game.your_role?
game.play
