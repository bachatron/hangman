def random_word()
  filtered_words = File.readlines('1000words.txt').select {|x| x.strip.length.between?(5, 12)}
  filtered_words[rand(0..999)].strip
end

current_word = random_word

puts current_word
puts current_word.length

player_word = Array.new(current_word.length, "_").join(' ')
#player_word[2] = "a"
puts player_word
