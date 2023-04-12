

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
    current_guess = ""
    puts "Enter your chosen letter! You can still make #{@guesses_left} mistakes."
    valid_input(player_input)
    check_letters
    p @guess
end

def check_letters
    if @word.hidden.include?(@guess)
        @word_progress.each_with_index do | letter, index |
            if @guess == @word.hidden[index]
                @word_progress[index] = @word.hidden[index]
            
        end
        end
    else 
        print "stil works but different"
    end
    display_word
end

def display_word
    puts "Already made guesses: #{@made_guesses}"
    puts "Progress: #{@word_progress.join(" ")}"
end 
    
def player_input
    @guess = gets.chop.to_s
end

def valid_input(players_guess)
    if !@made_guesses.include?(players_guess) && players_guess.match?(/[[:alpha]]/)
        @made_guesses.push(players_guess) 
        return players_guess
    else 
        puts "Not a valid input, try again"
        valid_input(player_input)
    end
end

end

Game.new.play