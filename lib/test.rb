Dir.mkdir('save') unless Dir.exist?('save')
filename = "save/saved_game"

array = ["a","b","c"]

File.open(filename, 'w') do |file|
  file.puts array
end