# frozen_string_literal: true

require 'colorize'

puts "Hangman works here\n"

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



  def play
    p @word.hidden
    puts "Hello there! The word you need to guess is selected! It has #{@word.hidden.length} letters"
    # loop
    loop do
      puts "Enter your chosen letter! You can still make #{@guesses_left.to_s.colorize(:yellow)} mistakes."
      valid_input(player_input)
      break if winner?
    end
  end

  private

  def winner?
    if @guesses_left.zero?
      puts 'GAME OVER'
      puts "The words was #{@word.hidden.colorize(:yellow)}"
      true
    elsif @word.hidden == @word_progress.join
      puts 'YOU WON'
      puts "The words was #{@word.hidden.colorize(:yellow)}"
      true
    else
      false
    end
  end

  def check_letters
    if @word.hidden.include?(@guess)
      @made_guesses.push(@guess.colorize(:green)) unless @made_guesses.include?(@guess)
      @word_progress.each_with_index do |_letter, index|
        @word_progress[index] = @word.hidden[index] if @guess == @word.hidden[index]
      end
    else
      @made_guesses.push(@guess.colorize(:red))
      puts 'This is not included in the word'
      @guesses_left -= 1
    end
    display_word
  end

  def display_word
    puts "Already made guesses: #{@made_guesses.join(' ')}"
    puts "Progress: #{@word_progress.join(' ')}"
  end

  def player_input
    @guess = gets.chop.downcase.to_s
  end

  def valid_input(players_guess)
    if (!@made_guesses.include?(players_guess.colorize(:green)) && 
        !@made_guesses.include?(players_guess.colorize(:red)) &&
        players_guess.match?(/[A-Za-z]/) && 
        players_guess.length == 1)
      check_letters
    else
      puts 'Not a valid input, try again'
      valid_input(player_input)
    end
  end
end

Game.new.play
