# frozen_string_literal: true

file = File.new('dictionary.txt')

words = file.readlines

words.select! { |el| el.chomp.length.between?(5, 12) }

File.delete('dictionary.txt')
file = File.new('dictionary.txt', 'w')
length = words.size
words.each_with_index { |el, index| index == length - 1 ? file.write(el.chomp) : file.write(el) }
file.close
