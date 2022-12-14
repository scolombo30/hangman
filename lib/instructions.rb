# frozen_string_literal: true

def print_instructions
  puts 'Instructions:'
  puts 'You will be given a word to guess, and you will have 6 chances to guess it.'
  puts 'If you guess the word before you run out of chances, you win!'
  puts 'If you run out of chances before you guess the word, you lose!'
  puts 'Good luck!'
end

def print_savings_files
  Dir.foreach('savings') do |file|
    puts file.gsub('.data', '') if file.include?('.data')
  end
end
