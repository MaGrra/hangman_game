require_relative 'game'

def save_game(game)
  puts 'Chose a name for the save'
  filename = get_save_name
  serialized_object = YAML.dump(game)
  File.open(File.join(Dir.pwd, "/saves/#{filename}.yaml"), 'w') { |file| file.write serialized_object }
end

def get_save_name
  filenames = Dir.glob('saves/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  filename = gets.chomp
  return filename unless filenames.include?(filename)

  puts 'This name is taken'
  get_save_name
end

def load_game
  filename = available_saves
  saved = File.open(File.join(Dir.pwd, "saves/#{filename}"), 'r')
  loaded_game = YAML.load(saved, permitted_classes: [Game, Words])
  saved.close
  loaded_game
end

def available_saves
  puts 'Chose your save game'
  filenames = Dir.glob('saves/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  puts filenames
  filename = gets.chomp
  if filenames.include?(filename)
    "#{filename}.yaml"

  else
    puts "\nTheres no such file here!\n\n".bold
    available_saves
  end
end

puts "\nWelcome to a game of Hangman!\n\n".bold
puts ' Enter one of the following  '
puts '        1 - New Game         '
puts '        2 - Load Game        '

player_choice = gets.chomp.to_i
until (1..2).include?(player_choice)
  puts 'You dumb or something? Enter 1 OR 2'
  player_choice = gets.chomp.to_i
end

game = player_choice == 1 ? Game.new : load_game

game.intro

until game.winner?
  next unless game.valid_input == 'save'

  save_game(game)
  puts 'Game has been saved!'
  break
end
