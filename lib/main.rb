require_relative 'hangman'
require_relative 'instructions'

puts "Welcome to the Hangman game!"
def new_game_or_load
  puts "Do you want to start a new game or load a saved game?"
  puts "Type 'new' to start a new game or 'load' to load a saved game."
  input = gets.chomp
  if input == "new"
    print_instructions
    game = Hangman.new
    game.play
  elsif input == "load"
    game = Hangman.load
    game
  end
end



