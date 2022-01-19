# frozen_string_literal: true

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
