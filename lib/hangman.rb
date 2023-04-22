def random_word
  filtered_words = File.readlines('1000words.txt').select {|x| x.strip.length.between?(5, 12)}
  filtered_words[rand(0..999)].strip
end

$current_word = random_word

$player_word = Array.new($current_word.length, "_")

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
end

def create_save
  Dir.mkdir('save') unless Dir.exist?('save')
  filename = "save/saved_game"

  array = [$current_word, $player_word.join(''), $used_letters.join(''), $lives]

  File.open(filename, 'w') do |file|
    file.puts array
  end
end

def save_game
  print "Type 'yes' to save the game and exit or press ENTER to continue "
  answer = gets.chomp.downcase until ['yes', ''].include?(answer)
  if answer == 'yes'
    create_save
    abort('Game saved.')
  end
end

def load_game
  filename = "save/saved_game"
  if File.exist?(filename)
    save_file = File.open(filename)
    save_content = save_file.readlines
    print "Previous game detected, do you want to load it? "
    answer = gets.chomp.downcase
    if answer == 'yes'
      $current_word = save_content[0]
      $player_word = save_content[1].split('')
      $used_letters = save_content[2].split('')
      $lives = save_content[3].to_i
    end
    save_file.close
    File.delete(filename)
  end
end

def play
  load_game
  until $current_word.split('') == $player_word
    update_game()
    save_game
    check_letter(select_letter)
    if $lives == 0
      puts "You loose, the word was #{$current_word}."
      break
    end
    puts "You won, the word was #{$current_word}" 
  end
end

play