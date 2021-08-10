class Hangman
  def initialize(word)
    @word = word
    @guesses = []
    @icon_indices = [18, 24, 25, 26, 32, 34]
  end

  def hanged_man(n)
    n = @icon_indices.length - 1 if n > @icon_indices.length - 1
    image = <<~MAN
        ___
       |   |
       |   O
       |  /|\\
       |  / \\
      _|_
    MAN
    (@icon_indices.length - 1).downto(n) { |i| image[@icon_indices[i]] = ' '}
    image
  end

  def guess(g)
    g = g.to_s
    @guesses.push(g) if g && g.length == 1
  end 

  def correct
    @word.chars.map.with_index do |c|
      if !@guesses.include?(c)
        '_ '
      else
        c + ' '
      end
    end.join
  end

  def guessed
    @guesses.join
  end
end