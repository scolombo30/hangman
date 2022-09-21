# frozen_string_literal: true

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

  def play
    loop do
      puts "You have #{chances_left} chances left."
      print_progress(word, guessed_letters)
      print_previous_guesses(guessed_letters, tried_letters)
      # ask for a letter or save,
      puts 'Enter a letter or type \'save\' to save the game.'
      input = check_input(gets.chomp.downcase)
      begin
        input == 'save' ? save : check_letter(input)
      rescue SavedError
        break
      end
      begin
        raise WinError if check_victory
      rescue WinError
        print_progress(word, guessed_letters)
        print_previous_guesses(guessed_letters, tried_letters)
        puts 'You guessed the correct word. You win!'
        break
      end
      begin
        raise LoseError if @chances_left.zero? && !check_victory
      rescue LoseError
        print_progress(word, guessed_letters)
        print_previous_guesses(guessed_letters, tried_letters)
        puts "You ran out of chances. The word was #{word}. You lose!"
        break
      end
    end
  end

  def save
    serialized_game = Marshal.dump(self)
    puts 'Enter a name for the save file.'
    filename = gets.chomp
    File.open("savings/#{filename}.data", 'w') { |file| file.write(serialized_game) }
    puts 'Game saved.'
    raise SavedError
  end

  def load(filename)
    # load game state from file
    File.open("savings/#{filename}.data", 'r') do |file|
      serialized_game = file.read
      game = Marshal.load(serialized_game)
      game.play
    end
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
      break if str == 'save' || str.match?(/[a-z]/) && str.length == 1

      puts 'Invalid input. Please enter a letter or type \'save\' to save the game.'
      str = gets.chomp.downcase
    end
    str
  end

  def check_letter(letter)
    if @word.include?(letter) && !@guessed_letters.include?(letter)
      @guessed_letters.push(letter)
    elsif @tried_letters.include?(letter) || @guessed_letters.include?(letter)
      puts 'You already tried that letter. Try again.'
    else
      @tried_letters.push(letter)
      @chances_left -= 1
    end
  end

  def check_victory
    @word.split('').all? { |letter| @guessed_letters.include?(letter) } ? true : false
  end
end
