def random_word
  filtered_words = File.readlines('1000words.txt').select {|x| x.strip.length.between?(5, 12)}
  filtered_words[rand(0..999)].strip
end

$current_word = random_word
puts $current_word

$player_word = Array.new($current_word.length, "_")
puts $player_word.join(' ')

$used_letters = []

$lives = 15

def check_letter(letter)
  if $current_word.include?(letter)
    $current_word.split('').each_with_index do |x, i|
      $player_word[i] = letter if x == letter
    end
  else
    $used_letters << letter
    $lives -= 1
  end
end

def select_letter
  letter = ""
  until letter.length == 1 && Array('a'..'z').include?(letter)
    print "Select a valid letter: "
    letter = gets.chomp.downcase
  end
  letter
end

def update_game
  print "\e[2J\e[f"
  puts "#{$player_word.join('')}\nUsed letters: #{$used_letters.uniq.join('')}\nLives: #{$lives.to_s}"
  save_game
end

def create_save
  Dir.mkdir('save') unless Dir.exist?('save')
  filename = "save/saved_game"

  array = [$current_word, $player_word, $used_letters, $lives]

  File.open(filename, 'w') do |file|
    file.puts array
  end
end

def save_game
  print "Type 'yes' to save the game or press ENTER to continue"
  answer = gets.chomp.downcase until ['yes', ''].include?(answer)
  create_save if answer == 'yes'
end


def play
  until $current_word.split('') == $player_word
    update_game()
    check_letter(select_letter)
    if $lives == 0
      puts "You loose, the word was #{$current_word}."
      break
    end
    puts "You won, the word was #{$current_word}" 
  end
end

play