# frozen_string_literal: true

require 'yaml'

class Words
  attr_reader :hidden

  def initialize
    filename = 'dictionary.txt'
    text = File.open(filename)
    all_words = File.read('dictionary.txt').split
    @hidden = all_words.select { |word| word.length > 5 && word.length < 13 }.sample
  end
end

class Game
  attr_accessor :guesses_left, :made_guesses, :word_progress, :guess
  attr_reader :word

  def initialize
    @word = Words.new
    @guesses_left = 9
    @made_guesses = []
    @word_progress = Array.new(@word.hidden.length, '_')
    @guess = ''
  end

  def intro
    puts "Hello there! The word you need to guess is selected! It has #{@word.hidden.length} letters\n\n"
  end

  def winner?
    zero = '0'
    if @guesses_left.to_s == zero.yellow || @guesses_left.zero?
      puts 'GAME OVER'
      puts "The words was #{@word.hidden.yellow}"
      true
    elsif @word.hidden == @word_progress.join
      puts 'YOU WON'
      puts "The words was #{@word.hidden.yellow}"
      true
    else
      false
    end
  end

  def check_letters
    if @word.hidden.include?(@guess)
      @made_guesses.push(@guess.green) unless @made_guesses.include?(@guess)
      @word_progress.each_with_index do |_letter, index|
        @word_progress[index] = @word.hidden[index] if @guess == @word.hidden[index]
      end
    else
      @made_guesses.push(@guess.red)
      puts 'This is not included in the word'
      @guesses_left -= 1
    end
  end

  def display_word
    puts "Already made guesses: #{@made_guesses.join(' ')}"
    puts "Progress: #{@word_progress.join(' ')}"
  end

  def player_input
    @guess = gets.chop.downcase.to_s
  end

  def valid_input
    puts "Enter your chosen letter! You can still make #{@guesses_left.to_s.yellow} mistakes."
    puts "Or write 'save' to save the game\n\n"
    display_word
    player_input
    if !@made_guesses.include?(@guess.green) &&
       !@made_guesses.include?(@guess.red) &&
       @guess.match?(/[A-Za-z]/) &&
       @guess.length == 1
      check_letters
    elsif @guess == 'save'
      'save'
    else
      puts 'Not a valid input, try again'.bold
    end
  end
end
