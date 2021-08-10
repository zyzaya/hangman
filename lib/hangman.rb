class Hangman
  attr_reader :word

  def initialize(word)
    @word = word
    @guesses = []
    @icon_indices = [18, 24, 25, 26, 32, 34]
    @incorrect = 0
  end

  def hanged_man
    image = <<~MAN
        ___
       |   |
       |   O
       |  /|\\
       |  / \\
      _|_
    MAN
    (@icon_indices.length - 1).downto(@incorrect) { |i| image[@icon_indices[i]] = ' '}
    image
  end

  def guess(g)
    g = g.to_s
    if g && g.length == 1
      @guesses.push(g)
      @incorrect += 1 unless @word.chars.include?(g)
    end
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

  def win?
    @word.chars.all? { |c| @guesses.include?(c) }
  end

  def loss?
    @incorrect >= @icon_indices.length
  end
end