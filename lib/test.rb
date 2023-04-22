file = File.open("../hangman/save/saved_game")
contents = file.readlines

puts contents[0]

file.close
