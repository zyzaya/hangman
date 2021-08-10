require_relative 'hangman'
require_relative 'word_library'
require_relative 'input'

class HangmanGame
  EXIT_CODE = %w[exit e]
  INTRO_MESSAGE = 'New game? (new). Or load a saved game? (load)'
  NEW_GAME = %w[new n]
  LOAD_GAME = %w[load l]
  GUESS_MESSAGE = 'Enter guess.'
  INVALID_GUESS = 'Invalid input. Guess must be 1 character that has not already been guessed'
  WIN_MESSAGE = 'You win! '
  LOSE_MESSAGE = 'You lose. The correct word was '
  AGAIN = 'Play again?'
  INVALID_AGAIN = 'Invalid input. ' + INTRO_MESSAGE

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
    @hangman = Hangman.new('hangman')
    p 'newing'
    play_game
  end

  def load_game
    p 'loading'
  end

  def play_game
    until @hangman.loss? || @hangman.win?
      g = @input.get(GUESS_MESSAGE, INVALID_GUESS) do |i|
        i.match?(/[A-Za-z]/) && !@hangman.guessed.chars.include?(i)
      end
      p g
      @hangman.guess(g)
      puts @hangman.hanged_man
      puts @hangman.guessed
      puts @hangman.correct
    end
    finish_game
  end

  def finish_game
    message =
      if @hangman.win?
        WIN_MESSAGE
      elsif @hangman.loss?
        LOSE_MESSAGE + "'#{@hangman.word}'. "
      end
    message += AGAIN
    puts message
    start
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

