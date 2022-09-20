# frozen_string_literal: false

require_relative 'hangman'
require_relative 'instructions'

puts 'Welcome to the Hangman game!'
puts 'Do you want to start a new game or load a saved game?'
puts "Type 'new' to start a new game or 'load' to load a saved game."
input = gets.chomp
case input
when 'new'
  print_instructions
  game = Hangman.new
  game.play
when 'load'
  puts 'Loading saved game...'
  #load saved game from file and get the game object. call play method with those arguments
  game = Hangman.new
  game.play(chances_left, word, guessed_letters, tried_letters)
end
