# Load the dictionary, store it in an array, shuffle it
dictionary = File.open('dictionary.txt')
dictionary_array = dictionary.readlines
dictionary_array.shuffle!

# Intro text, wait for user to type 'start'
puts "\n<<< Terminal Hangman >>>\n\n"
puts "Type \"start\" to begin a new game\n"
turn = 0
rematch = nil

print "> "
user_word = gets.chomp.downcase.strip
until user_word == "start"
print "> "
user_word = gets.chomp.downcase.strip
end

puts "Generating your word...\n\n"

# Loop the game until the user types 'quit'
until rematch == "quit"

  # Get a word, put the chars into an array, make an array of letters remaining
  dictionary_array.shuffle!
  word = dictionary_array[17]
  word_array = word.chars.to_a
  letters_remaining = dictionary_array[17].chars.to_a
  # Get rid of \r\n
  word_array.delete_at(word_array.length-1)
  word_array.delete_at(word_array.length-1)
  letters_remaining.delete_at(letters_remaining.length-1)
  letters_remaining.delete_at(letters_remaining.length-1)


# Initialize Alphabet and Lives
alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
"L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]


  # If it is the first turn OR they choose to rematch
  if rematch == "new" || turn == 0
  word_array.each do |x|
    print "_ "
  end
  puts "\n\n"

  puts "Word generated!\n"
  puts "Lives Remaining: #{lives}"
  puts "Letters Remaining: "

  alphabet.each do |x|
    print "#{x} "
  end
  puts "\n\n"

  puts "Guess a letter: "
  print "> "
  guess = gets.chomp.upcase.strip

  until alphabet.include?(guess) == true
    puts "INVALID ENTRY"
    puts "Please guess from the available letters"
    print "> "
    guess = gets.chomp.upcase.strip
  end

  # After the first guess, only break if lives are 0 or no letters remaining
  until lives == 0 || letters_remaining == []

    if word_array.include?(guess.downcase) == true

      puts "\n\n"
      alphabet.delete(guess)
      letters_remaining.delete(guess.downcase)

      if letters_remaining == []
        break
      end

      word_array.each do |x|
        if alphabet.include?(x.upcase) == true
          print "_ "
        else
          print "#{x.upcase} "
        end
      end

      puts "\n\n"
      puts "Lives Remaining: #{lives}"
      puts "Letters Remaining: "

      alphabet.each do |x|
        print "#{x} "
      end
      puts "\n\n"

      puts "Guess a letter: "
      print "> "
      guess = gets.chomp.upcase.strip

      until alphabet.include?(guess) == true
         puts "INVALID ENTRY"
         puts "Please guess from the available letters"
         print "> "
         guess = gets.chomp.upcase.strip
      end

    elsif lives > 1
      lives -= 1

      puts "WRONG!\n\n"
      alphabet.delete(guess)

      word_array.each do |x|
        if alphabet.include?(x.upcase) == true
          print "_ "
        else
          print "#{x.upcase} "
        end
      end

      puts "\n\n"
      puts "Lives Remaining: #{lives}"
      puts "Letters Remaining: "

      alphabet.each do |x|
        print "#{x} "
      end
      puts "\n\n"

      puts "Guess a letter: "
      print "> "
      guess = gets.chomp.upcase.strip

      until alphabet.include?(guess) == true
         puts "INVALID ENTRY"
         puts "Please guess from the available letters"
         print "> "
         guess = gets.chomp.upcase.strip
      end

    else
      lives -= 1
      puts "YOU LOSE!\n"
      puts "The word was #{word_array.to_s.upcase}"
    end

  end # of first guess until

  if letters_remaining == []
    puts "CONGRATULATIONS! You got the word #{word_array.to_s.upcase}"
  end

  turn += 1
  puts "Type \"new\" to play again, type \"quit\" to exit"
  print "> "
  rematch = gets.chomp.downcase.strip
  else
  puts "Please type either \"new\" OR \"quit\""
  end

end
