def random_word()
  filtered_words = File.readlines('1000words.txt').select {|x| x.strip.length.between?(5, 12)}
  filtered_words[rand(0..999)].strip
end

$current_word = random_word.split('')
puts $current_word

$player_word = Array.new($current_word.length, "_")
puts $player_word.join(' ')

def check_letter(letter)
  $current_word.each_with_index do |x, i|
    $player_word[i] = letter if x == letter
  end
  puts $player_word.join(' ')
end

check_letter('e')

while $player_word.include?('_')
  Array('a'..'z').each {|letter| check_letter(letter)}
end

class Player
  
  def initialize
    @lives = 15
  end

  def select_letter
    print "Select a valid letter: "
    loop do
      letter = gets.chomp until letter.length == 1 && Array('a'..'z').include(letter)
    end
  end

  def check_letter(letter, game_word)
    game_word.each_with_index do |x, i|
      game_word[i] = letter if x == letter
    end
    puts game_word.join(' ')
  end

end

class Game

  def initialize
    word = random_word
