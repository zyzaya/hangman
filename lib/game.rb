require_relative 'hangman'

test_g = %w[h n g t l z o]
hangman = Hangman.new('hangman')
image = hangman.hanged_man(2)
test_g.each { |g| hangman.guess(g)}
puts image
puts hangman.guessed
puts hangman.correct
p image
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

