# frozen_string_literal: true

# Helps constructing valid code for Coder/Decoder
module CodeMaker
  private_constant :NUM_FOR_COLOR, :LETTER_FOR_COLOR, :MIN_COLOR, :MAX_COLOR
  NUM_FOR_COLOR = { 1 => 'RED', 2 => 'GREEN', 3 => 'BLUE', 4 => 'YELLOW', 5 => 'ORANGE', 6 => 'PURPLE' }.freeze
  LETTER_FOR_COLOR = { R: 'RED', G: 'GREEN', B: 'BLUE', Y: 'YELLOW', O: 'ORANGE', P: 'PURPLE' }.freeze
  MIN_COLOR = 1
  MAX_COLOR = 6
  def random_code
    code = []
    until code.length == 4
      choice = rand(MIN_COLOR, MAX_COLOR)
      code << NUM_FOR_COLOR[choice]
    end
    code
  end
  def create_code

  end
end
