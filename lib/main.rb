# frozen_string_literal: false

require_relative 'hangman'
require_relative 'instructions'

def check_input(str)
  loop do
    return str if %w[new load].include?(str)

    puts 'Invalid input. Enter \'new\' or \'load\''
    str = gets.chomp.downcase
  end
end

puts 'Welcome to the Hangman game!'
puts 'Do you want to start a new game or load a saved game?'
puts "Type 'new' to start a new game or 'load' to load a saved game."

input = check_input(gets.chomp.downcase)
if input == 'new'
  print_instructions
  Hangman.new.play
else
  puts 'Loading saved game...'
  # load saved game from file and get the game object. call play method with those arguments
  game = Hangman.new
  game.play(chances_left, word, guessed_letters, tried_letters)
end
