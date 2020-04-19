
require 'ruby2d'
set background: 'white'
#v0.4.5 needs window to close
#24/10/20 4:50 pm - Sam

require 'ruby2d'
set background: 'white'
#v0.4 more user friendly, check imstuck.docs in shared folder
#2/24/20 1:43 pm - Ryan

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
  File.open("dictionary.txt") do |file|
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
      #tob horizonatal bar
      Line.new(
      x1:310, y1: 10,
      x2:575, y2: 10,
      color: 'black',
      width: 20,
      z:10
      )

      #right vertical bar
      Line.new(
      x1:560, y1: 10,
      x2:560, y2: 420,
      color: 'black',
      width: 30,
      z:10
      )

      # bottom bar
      Line.new(
      x1:620, y1: 420,
      x2:500, y2: 420,
      color: 'black',
      width: 30,
      z:10
      )

      #rope
      Line.new(
      x1:320, y1: 10,
      x2:320, y2: 180,
      color: 'black',
      width: 5,
      z:10
      )


  when 5
    update do
      #head
      Circle.new(
        x: 320, y: 150,
        radius: 30,
        sectors: 32,
        color: 'black',
        z: 1
      )

    end
  when 4
    update do
      #body
      Line.new(
      x1:320, y1: 150,
      x2:320, y2: 240,
      color: 'black',
      width: 20,
      z:10
      )
    end
  when 3
    update do
      #arm1
      Line.new(
      x1:320, y1: 150,
      x2:290, y2: 240,
      color: 'black',
      width: 12.5,
      z:10
      )
    end

  when 2
    update do
      #arm2
      Line.new(
      x1:320, y1: 150,
      x2:350, y2: 240,
      color: 'black',
      width: 12.5,
      z:10
      )
    end
  when 1
    update do
      #leg1
      Line.new(
      x1:320, y1: 240,
      x2:290, y2: 330,
      color: 'black',
      width: 12.5,
      z:10
      )
    end
  else
    update do
    #leg2
    Line.new(
    x1:320, y1: 240,
    x2:350, y2: 330,
    color: 'black',
    width: 12.5,
    z:10
    )
    end
  end #end switch case
  show
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
  secret_word_array = secret_word.chars.to_a
  puts "Word generated!\n"
  puts "The secret_word to guess is: #{secret_word}"
  #puts "the random line is #{word}"
  #regex or something to ignore spaces
  #secret_word = "samcancoderuby"
  #user_input.downcase!
  #secret_word_length = secret_word.length
  #user_input = "zzz"
  #initalizes user_input to be a word not in the dictionary.txt
  alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
  "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "\'"]
  lives = 6
  out_of_lives = false
  letters_remaining = secret_word.length
  display_hangman(lives)
  puts "Letters Remaining: #{letters_remaining}"
  secret_word_array.each do |x|
    print "_ "
  end
  puts"\n\n"

  while !out_of_lives
    #user_input != secret_word and !out_of_guesses
    if lives > 0
      update do
        close
      end
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
      puts "The secret word contains: #{user_input}";
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
        puts "The word is #{secret_word}"
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
  when "quit"
    puts "Have a great day!"
    return
  else
    puts "Im sorry, not sure what you meant"
  end #end switch case
end #end while
#ENDMAIN------------------------------------------------------------------------
