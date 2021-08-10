require_relative 'hangman'
require_relative 'word_library'

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

