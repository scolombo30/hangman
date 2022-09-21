# frozen_string_literal: false

require_relative 'hangman'
require_relative 'instructions'

def check_input(str)
  loop do
    return str if %w[new load delete].include?(str)

    puts 'Invalid input. Enter \'new\' or \'load\''
    str = gets.chomp.downcase
  end
end

def saving_file_exist(filename)
  until File.exist?("savings/#{filename}.data")
    puts 'File not found. Try again.'
    filename = gets.chomp
  end
  filename
end

puts 'Welcome to the Hangman game!'
puts 'Do you want to start a new game or load a saved game?'
puts "Type 'new' to start a new game, 'load' to load a saved game or 'delete' to delete a saved game."

input = check_input(gets.chomp.downcase)
case input
when 'new'
  print_instructions
  Hangman.new.play
when 'load'
  puts 'Wich game do you want to load?'
  print_savings_files
  filename = saving_file_exist(gets.chomp)
  puts filename
  puts 'Loading saved game...'
  Hangman.new.load(filename)
else
  puts 'Wich game do you want to delete?'
  print_savings_files
  filename = saving_file_exist(gets.chomp)
  File.delete("savings/#{filename}.data")
  puts 'File deleted.'
end
