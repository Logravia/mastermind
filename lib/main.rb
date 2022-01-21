# frozen_string_literal: true

require_relative 'player_decoder'
require_relative 'computer_coder'
require_relative 'game'
require_relative 'display'

game = Game.new
game.play
