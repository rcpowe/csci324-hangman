#randomline.rb
def pick_random_line
  random_line = nil
  File.open("dictionary.txt") do |file|
    file_lines = file.readlines()
    random_line = file_lines[Random.rand(0...file_lines.size())]
    puts "#{random_line}"
    close.File
    return random_line
  end

end
word = pick_random_line()
puts "the random line is #{word}"
