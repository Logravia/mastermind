# lib/input_helper.rb

module InputHelper
  def self.bad_input_msg
    puts 'Seems like your input was invalid. Try again or press q to quit.'
  end
  def self.get_choices(acceptable_pattern)
    print '> '
    input = gets
    exit if input == "q\n"
    choices = input.scan(acceptable_pattern)
    if choices.length.zero?
      bad_input_msg
      choices = get_choices(acceptable_pattern)
    end
    choices
  end
end
