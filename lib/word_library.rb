class WordLibrary
  def initialize
    @words = File.readlines('words.txt', chomp: true).select { |w| w.length <= 12 && w.length >=5 }
  end

  def random
    @words[rand(@words.length)]
  end
end
