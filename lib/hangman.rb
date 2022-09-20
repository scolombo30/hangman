require 'colorized_string'
class Hangman
  attr_accessor :word
  attr_accessor :chances_left
  attr_accessor :guessed_letters
  attr_accessor :tried_letters

  def initialize
    dictionary = File.open('dictionary.txt')
    words = dictionary.readlines
    @word = words[rand(words.length) - 1].chomp
    @chances_left = 6
    @guessed_letters = []
    @tried_letters = []
    dictionary.close
  end

  def play (
    chances_left = @chances_left, 
    word = @word, 
    guessed_letters = @guessed_letters, 
    tried_letters = @tried_letters
    )
    puts "You have #{chances_left} chances left."
    print_progress(word, guessed_letters)
    print_previous_guesses(guessed_letters, tried_letters)
    #ask for a letter or save, check the input
    #check if letter is in word
    #if letter is in word, add to guessed_letters
    #if letter is not in word, add to tried_letters
    #if chances_left == 0, game over
    #if guessed_letters == word, game won
    #else, play again and decrement chances_left and call play again
  end

  def save;end

  private
  def print_progress(word, guessed_letters)
    word.each_char do |letter|
      if guessed_letters.include?(letter)
        print "#{letter} "
      else
        print '_ '
      end
    end
  end

  def print_previous_guesses(guessed_letters, tried_letters)
    print ColorizedString['  ✓: '].colorize(:green)
    guessed_letters.each {|letter| print ColorizedString[" #{letter} "].colorize(color: :white, background: :green)}
    print ColorizedString['  ✗: '] .colorize(:red)
    tried_letters.each_with_index {|letter| print ColorizedString[" #{letter} "].colorize(color: :white, background: :red)}
    puts ''
  end
end
