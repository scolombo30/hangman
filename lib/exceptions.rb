class WinError < StandardError
  def initialize
    puts 'You guessed the correct word. You win!'
    super
  end
  
end

class LoseError < StandardError
  def initialize(word)
    puts "You ran out of chances. The word was #{word}. You lose!"
    super
  end
end
