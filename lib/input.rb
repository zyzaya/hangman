# frozen_string_literal: true

class Input
  attr_reader :exit_code

  def initialize(exit_code)
    @exit_code = exit_code
  end

  def get(info, retry_text, valid_input = nil, &block)
    puts info
    valid = false
    until valid
      input = gets.chomp.downcase
      valid = 
        @exit_code.include?(input) ||
        (block.call(input) unless block.nil?) ||
        (valid.input.include?(input) unless valid_input.nil?)
      puts retry_text unless valid
    end
    input
  end
end
