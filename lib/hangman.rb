require 'colorized_string'
class Hangman
  attr_accessor :word
  def initialize
    dictionary = File.open('dictionary.txt')
    words = dictionary.readlines
    @word = words[rand(words.length) - 1].chomp
    dictionary.close
  end

  def play(chances_left = 6, word = @word, guessed_letters = ['a','v'], tried_letters = ['f','g'])
    puts "You have #{chances_left} chances left."
    print_progress(word, guessed_letters)
    print_previous_guesses(guessed_letters, tried_letters)
  end

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
