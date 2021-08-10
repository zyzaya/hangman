require_relative 'hangman'
require_relative 'word_library'
require_relative 'input'

class HangmanGame
  EXIT_CODE = %w[exit e]
  INTRO_MESSAGE = 'New game? (new). Or load a saved game? (load)'
  NEW_GAME = %w[new n]
  LOAD_GAME = %w[load l]

  def initialize
    @library = WordLibrary.new
    @input = Input.new(EXIT_CODE)
  end

  def start
    user_input = @input.get(
      INTRO_MESSAGE,
      'Invalid input. ' + INTRO_MESSAGE,
      NEW_GAME + LOAD_GAME
    )
    if NEW_GAME.include?(user_input)
      new_game
    elsif LOAD_GAME.include?(user_input)
      load_game
    end
  end

  private

  def new_game
    @hangman = Hangman.new(@library.random)
    p 'newing'
  end

  def load_game
    p 'loading'
  end

  def play_game
    
  end
end

hangman = HangmanGame.new
hangman.start

# exit_code = %w[exit e]
# test_input = %w[new n load l]
# input = Input.new(exit_code)
# input.get('enter stuff', 'not that') { |i| i == 'new'}

# test_g = %w[h n g t l z o]
# hangman = Hangman.new('hangman')
# image = hangman.hanged_man(2)
# test_g.each { |g| hangman.guess(g)}
# puts image
# puts hangman.guessed
# puts hangman.correct
# p image

# library = WordLibrary.new
# 0.upto(12) { p library.random }
# p library.random

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

