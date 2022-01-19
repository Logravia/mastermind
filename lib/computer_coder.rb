# frozen_string_literal: true

# Manages creation of a random color code, checking it against player's guess and giving hints based on the guess
class ComputerCoder
  def initialize
    @code_to_break = random_code
  end
  NUM_FOR_COLOR = { 1 => 'RED', 2 => 'GREEN', 3 => 'BLUE', 4 => 'YELLOW', 5 => 'ORANGE', 6 => 'PURPLE' }.freeze
  MIN_COLOR = 1
  MAX_COLOR = 6

  private

  def random_code
    code = []
    until code.length == 4
      choice = rand(MIN_COLOR..MAX_COLOR)
      code << NUM_FOR_COLOR[choice]
    end
    code
  end
  private_constant :NUM_FOR_COLOR, :MIN_COLOR, :MAX_COLOR
end
