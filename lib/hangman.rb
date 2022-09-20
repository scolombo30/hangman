class Hangman
  attr_accessor :word
  def initialize
    dictionary = File.open('dictionary.txt')
    words = dictionary.readlines
    @word = words[rand(words.length) - 1].chomp
    dictionary.close
  end

  def play
    
  end
end
