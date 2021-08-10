require_relative 'hangman'
require_relative 'word_library'
require_relative 'input'

class HangmanGame
  def initialize
    @library = WordLibrary.new
  end

  def start
    # new/load gameinput
    # play_game
  end

  private

  def new_game
    @hangman = Hangman.new(@library.random)
    play_game
  end

  def load_game
  
  end

  def play_game
    
  end
end

exit_code = %w[exit e]
test_input = %w[new n load l]
input = Input.new(exit_code)
input.get('enter stuff', 'not that') { |i| i == 'new'}

# test_g = %w[h n g t l z o]
# hangman = Hangman.new('hangman')
# image = hangman.hanged_man(2)
# test_g.each { |g| hangman.guess(g)}
# puts image
# puts hangman.guessed
# puts hangman.correct
# p image

library = WordLibrary.new
0.upto(12) { p library.random }
p library.random

#   ___
#  |   |
#  |   O
#  |  /|\
#  |  / \
# _|_

# _O_
#  |
#  |
# / \

#  O
# /|\
# / \

