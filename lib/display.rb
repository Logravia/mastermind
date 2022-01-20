require 'pry-byebug'

class Display
  COLOR_BLOCKS = {RED:"\e[41m", GREEN: "\e[42m", YELLOW: "\e[43m", BLUE: "\e[44m", PURPLE: "\e[45m", CYAN: "\e[46m", BLACK_FONT: "\e[30m", END: "\e[39m\e[49m"}
  private_constant :COLOR_BLOCKS
  def initialize
  end
  def show_code(code)
    print COLOR_BLOCKS[:BLACK_FONT]
    code.each_with_index do |color, index|
      print "#{COLOR_BLOCKS[color.to_sym]} #{index+1} "
    end
    puts COLOR_BLOCKS[:END]
  end

  def show_history(history)
  end

  def clear
    system "clear"
  end

end
