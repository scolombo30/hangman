require 'colorized_string'
require_relative 'exceptions'
class Hangman
  attr_accessor :word, :chances_left, :guessed_letters, :tried_letters

  def initialize
    dictionary = File.open('dictionary.txt')
    words = dictionary.readlines
    @word = words[rand(words.length) - 1].chomp
    @chances_left = 6
    @guessed_letters = []
    @tried_letters = []
    dictionary.close
  end

  def play(
    chances_left = @chances_left,
    word = @word,
    guessed_letters = @guessed_letters,
    tried_letters = @tried_letters
    )
    puts word
    puts "You have #{chances_left} chances left."
    print_progress(word, guessed_letters)
    print_previous_guesses(guessed_letters, tried_letters)
    # ask for a letter or save,
    puts 'Enter a letter or type \'save\' to save the game.'
    input = check_input(gets.chomp.downcase)
    input == 'save' ? save : check_letter(input)
    check_victory ? (raise WinError) : (@chances_left -= 1)
    @chances_left.zero? && !check_victory ? (raise LoseError(@word)) : play
  end

  def save
    # end game after saving game state
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
    guessed_letters.each { |letter| print ColorizedString[" #{letter} "].colorize(color: :white, background: :green) }
    print ColorizedString['  ✗: '].colorize(:red)
    tried_letters.each { |letter| print ColorizedString[" #{letter} "].colorize(color: :white, background: :red) }
    puts ''
  end

  def check_input(str)
    loop do
      break if str == 'save' || str.match?(/[a-z]/)

      puts 'Invalid input. Please enter a letter or type \'save\' to save the game.'
      str = gets.chomp.downcase
    end
    str
  end

  def check_letter(letter)
    if @word.include?(letter)
      @guessed_letters.push(letter)
    else
      @tried_letters.push(letter)
    end
  end

  def check_victory
    @guessed_letters.all? { |letter| @word.include?(letter) } ? true : false
  end
end
