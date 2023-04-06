

puts "Hangman works here\n"

class Words 

    
filename = "dictionary.txt"
text = File.open(filename)
all_words = File.read("dictionary.txt").split
nice_word = all_words.select { |word| word.length > 5 && word.length < 13}.sample
p nice_word

end