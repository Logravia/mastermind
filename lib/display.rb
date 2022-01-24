# frozen_string_literal: true

require 'pry-byebug'

class Display
  COLOR_BLOCKS = { RED: "\e[41m", GREEN: "\e[42m", YELLOW: "\e[43m", BLUE: "\e[44m", PURPLE: "\e[45m", CYAN: "\e[46m",
                   BLACK_FONT: "\e[30m", END: "\e[39m\e[49m" }.freeze
  private_constant :COLOR_BLOCKS

  CHOICES = ["RED", "GREEN", "YELLOW", "BLUE", "PURPLE", "CYAN"]

  def choices
    puts "These are your colors to choose from: "
    CHOICES.each_with_index do |color, i|
      print COLOR_BLOCKS[:BLACK_FONT]
      print "#{COLOR_BLOCKS[color.to_sym]} #{CHOICES[i][0]} "
      print "#{COLOR_BLOCKS[:END]} "
    end
  end

  def rules; end

  def show_code(code)
    code.each_with_index do |color, index|
      print COLOR_BLOCKS[:BLACK_FONT]
      print "#{COLOR_BLOCKS[color.to_sym]} #{index + 1} "
      print "#{COLOR_BLOCKS[:END]} "
    end
  end

  def history(history)
    history.each do |guess_round, hint|
      print "ROUND #{guess_round[:round] + 1}: "
      show_code(guess_round[:guess])
      print "\n"
      print "PERFECT: #{hint[:perfect]} PARTIAL: #{hint[:partial]}\n"
    end
  end

  def clear
    system 'clear'
  end
end
