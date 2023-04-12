

puts "Hangman works here\n"

class Words 
    attr_reader :hidden

def initialize 
    filename = "dictionary.txt"
    text = File.open(filename)
    all_words = File.read("dictionary.txt").split
    @hidden = all_words.select { |word| word.length > 5 && word.length < 13}.sample
end

end

class Game
    attr_accessor :guesses_left, :made_guesses, :word_progress, :guess
    attr_reader :word
   def initialize
    @word = Words.new
    @guesses_left = 9
    @made_guesses = []
    @word_progress = Array.new(@word.hidden.length, "_")
    @guess = ""
   end

def play
    p @word.hidden
    puts "Hello there! The word you need to guess is selected! It has #{@word.hidden.length} letters"
    #loop
    loop do 
    current_guess = ""
    puts "Enter your chosen letter! You can still make #{@guesses_left} mistakes."
    valid_input(player_input)
    check_letters
    break if winner?
    end
end

def winner?
    if @guesses_left == 0 
        puts "GAME OVER"
        puts "The words was #{@word.hidden}"
        return true
    elsif @word.hidden == @word_progress.join
        puts "YOU WON"
        puts "The words was #{@word.hidden}"
        return true
    else 
        return false
    end

end

def check_letters
    if @word.hidden.include?(@guess)
        @word_progress.each_with_index do | letter, index |
            if @guess == @word.hidden[index]
                @word_progress[index] = @word.hidden[index]
            
        end
        end
    else 
        puts "This is not included in the word"
        @guesses_left -= 1
    end
    display_word
end

def display_word
    puts "Already made guesses: #{@made_guesses}"
    puts "Progress: #{@word_progress.join(" ")}"
end 
    
def player_input
    @guess = gets.chop.downcase.to_s
end

def valid_input(players_guess)
    if !@made_guesses.include?(players_guess) && players_guess.match?(/[A-Za-z]/)
        @made_guesses.push(players_guess) 
    else 
        puts "Not a valid input, try again"
        valid_input(player_input)
    end
end

end

Game.new.play