require_relative 'hangman'
require_relative 'word_library'
require_relative 'input'
require 'yaml'

class HangmanGame
  YES = %w[yes y]
  NO = %w[no n]
  EXIT_CODE = %w[exit ex]
  INTRO_MESSAGE = 'New game? (new). Or load a saved game? (load)'
  NEW_GAME = %w[new n]
  LOAD_GAME = %w[load l]
  SAVE_GAME = %w[save sa]
  GUESS_MESSAGE = 'Enter guess. Or \'save\' to save game.'
  INVALID_GUESS = 'Invalid input. Guess must be 1 character that has not already been guessed'
  WIN_MESSAGE = 'You win! '
  LOSE_MESSAGE = 'You lose. The correct word was '
  AGAIN = 'Play again?'
  INVALID_AGAIN = 'Invalid input. ' + INTRO_MESSAGE
  SAVE_MESSAGE = 'Enter name of save.'
  INVALID_SAVE = 'Invalid input ' + SAVE_MESSAGE
  LOAD_MESSAGE = 'Select save.'
  INVALID_LOAD = 'Invalid input. ' + LOAD_MESSAGE
  QUIT_MESSAGE = 'Quit game? (yes/no)'
  INVALID_QUIT = 'Invalid input. Enter \'yes\' or \'no\'.'

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
    @save_name = ""
    play_game
  end

  def load_game
    saves = Dir['saves/*.hm']
    saves = saves.map { |s| File.basename(s, '.hm') }
    puts saves
    filename = @input.get(LOAD_MESSAGE, INVALID_LOAD) do |i|
      i.match?(/[A-Za-z]*/) && !File.exist?(i + '.hm')
    end
    @save_name = 'saves/' + filename + '.hm'
    @hangman = YAML.load(File.read(@save_name))
    play_game
  end

  def play_game
    user_input = ""
    until @hangman.loss? || @hangman.win?
      puts @hangman.hanged_man
      puts @hangman.guessed
      puts @hangman.correct
      user_input = @input.get(GUESS_MESSAGE, INVALID_GUESS, SAVE_GAME) do |i|
        i.match?(/[A-Za-z]/) && !@hangman.guessed.chars.include?(i)
      end
      return if EXIT_CODE.include?(user_input)

      if SAVE_GAME.include?(user_input)
        save_game
        puts 'Game saved'
        user_input = @input.get(QUIT_MESSAGE, INVALID_QUIT, YES + NO)
        return if (EXIT_CODE + YES).include?(user_input)

      else
        @hangman.guess(user_input)
      end
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

  def save_game
    Dir.mkdir('saves') unless Dir.exist?('saves')
    if @save_name == ""
      @save_name = @input.get(SAVE_MESSAGE, INVALID_SAVE) do |i|
        i.match?(/[A-Za-z]*/) && !File.exist?(i + '.hm')
      end
      @save_name = 'saves/' + @save_name + '.hm'
    end
    File.open(@save_name, 'w') do |file|
      file.puts YAML.dump(@hangman)
    end
  end
end

hangman = HangmanGame.new
hangman.start
