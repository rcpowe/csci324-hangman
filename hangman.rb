#v0.5 prints special chars not in the alphabet. Secret word is printed for testing
# 	and set to be king’s
#4/10/20 2:44 pm - Ryan

def genOutput (word)
  i = 0
  output = []
  while i < word.length
    output[i] = "_"
    #puts "#{output}"
    #puts "#{output.length}"
    i+=1
  end
  return output
end

def comparify (input, word)
  i = 0
  #j = 0
  outputter = genOutput(word)
  while i < word.length
    print "#{word[i]}"
    #puts is like println print does not add \n
    if word[i].eql? input
      outputter[i] = input
      #puts "#{outputter}"
      #return outputter
      #puts "#{outputter}"
    else
      outputter[i] = "_"
    end
    i+=1
  end
  puts ""
  return outputter
end

def pick_random_line
  random_line = nil
  File.open("testdict.txt") do |file|
    file_lines = file.readlines()
    random_line = file_lines[Random.rand(0...file_lines.size())]
    #puts "#{random_line}"
    #close.File
    return random_line
  end
end

def display_hangman (lives)
  puts "Lives Remaining: #{lives}"
  case lives
  when 6
    puts "        \+---\+ "
    puts "        |   | "
    puts "            | "
    puts "            | "
    puts "            | "
    puts "            | "
    puts "    ========= "

  when 5
    puts "        \+---\+ "
    puts "        |   | "
    puts "        O   | "
    puts "            | "
    puts "            | "
    puts "            | "
    puts "    ========= "
  when 4
    puts "        \+---\+ "
    puts "        |   | "
    puts "        O   | "
    puts "        |   | "
    puts "            | "
    puts "            | "
    puts "    ========= "
  when 3
    puts "        \+---\+ "
    puts "        |   | "
    puts "        O   | "
    puts "       /|   | "
    puts "            | "
    puts "            | "
    puts "    ========= "
  when 2
    puts "        \+---\+ "
    puts "        |   | "
    puts "        O   | "
    puts "       /|\\  | "
    puts "            | "
    puts "            | "
    puts "    ========= "
  when 1
    puts "        \+---\+ "
    puts "        |   | "
    puts "        O   | "
    puts "       /|\\  | "
    puts "       /    | "
    puts "            | "
    puts "    ========= "
  else
    puts "        \+---\+ "
    puts "        |   | "
    puts "        O   | "
    puts "       /|\\  | "
    puts "       / \\  | "
    puts "            | "
    puts "    ========= "
  end #end switch case
  return
end #end display_hangman()

def display_welcome
  puts "Welcome to Hangman in ruby"
  puts "Implemented by Sam Appleton and Ryan Powell"
  puts "in the year 2020. We hope you have fun!"
end #end display_welcome

def display_commands
  puts "You can type the following commands while"
  puts "in the main menu:"
  puts "rules"
  puts "commands"
  puts "play"
  puts "add a word"
  puts "quit"
  return
end #end display_commands

def display_rules
 puts "The rules of the game are simple"
 puts "Guess the secret word letter by letter"
 puts "You have six lives so be careful"
 return
end #end display_rules

def display_letters_left(array)
  array.each do |x|
    print "#{x} "
  end #end do
  puts "\n\n"
end #end display_letters_left

def play
  puts "Generating secret word..."
  secret_word = pick_random_line().downcase.strip
  #secret_word = "king's"
  secret_word_array = secret_word.chars.to_a
  puts "Word generated!\n"
  puts "The secret word to guess is: #{secret_word}"
  #puts "the random line is #{word}"
  #regex or something to ignore spaces
  #secret_word = "samcancoderuby"
  #user_input.downcase!
  #secret_word_length = secret_word.length
  #user_input = "zzz"
  #initalizes user_input to be a word not in the dictionary.txt
  alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
  "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  lives = 6
  out_of_lives = false
  letters_remaining = secret_word.length
  display_hangman(lives)

  secret_word_array.each do |x|
    if alphabet.include?(x.downcase) == true
      print "_ "
    else
      print "#{x.downcase} "
      letters_remaining -= 1
    end
  end
  puts"\n"
  puts "Letters Remaining: #{letters_remaining}"
  while !out_of_lives
    #user_input != secret_word and !out_of_guesses
    if lives > 0
      display_letters_left(alphabet)
      puts "Guess a letter: "
      user_input = gets.chomp.downcase.strip
      until alphabet.include?(user_input)
         puts "INVALID ENTRY"
         puts "Please guess from the available letters"
         display_letters_left(alphabet)
         puts "Guess a letter: "
         user_input = gets.chomp.downcase.strip
      end
      alphabet.delete(user_input)
    else
      out_of_lives = true
    end #end if else

    if secret_word_array.include? user_input
      #outputBlank = genOutput(secret_word)
      #puts "#{secret_word}"
      #outputCurrent = comparify(user_input, secret_word)
      #puts "The secret word contains: #{user_input}";
      #puts "#{outputBlank}"
      #puts "#{outputCurrent}"
      #user_input.gsub!(/s/, "th")
      #puts "#{secret_word}"
      correct_guesses = 0
      secret_word_array.each do |x|
        if alphabet.include?(x.downcase) == true
          print "_ "
        else
          print "#{x.downcase} "
          correct_guesses += 1
        end
      letters_remaining = (secret_word.length - correct_guesses)
      end
      puts ""
      puts "Letters Remaining: #{letters_remaining}"

      if correct_guesses == secret_word.length
        puts "CONGRATULATIONS"
        puts "The word is #{secret_word.upcase}"
        puts "You Win!"
        return
      end #end if
    else
      lives -= 1
      if lives > 0
        puts "Oh no, you lost a life!"
      else
        puts "Oh No!"
        puts "The word was #{secret_word.upcase}"
        puts "Game Over"
      end #end if else
      if lives > -1
        display_hangman(lives)
      end #end if
    end #end if else

  end #end while

end #end play()
def add_a_word
  puts "What word would you like to add to the dictionary?"
  word_to_add = gets.chomp.downcase.strip
  open('testdict.txt', 'a') { |f|
  f.puts word_to_add
}
  puts "The word has been added!"
end
#STARTMAIN----------------------------------------------------------------------
display_welcome()
display_commands()
command = "something"
while command != "quit"
  puts "What would you like to do?"
  command = gets.chomp
  case command
  when "rules"
    display_rules()
  when "play"
    play()
  when "commands"
    display_commands()
  when "add a word"
    add_a_word()
  when "quit"
    puts "Have a great day!"
    return
  else
    puts "Im sorry, not sure what you meant"
  end #end switch case
end #end while
#ENDMAIN------------------------------------------------------------------------
