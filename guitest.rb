require 'ruby2d'
set background: 'white'

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

def displayalphabet
  count = 0
  $alphabet.each do |i|
    Text.new(
      i,
    x: $startx + (count * 10),
    y: $starty,
    #font: 'vera.ttf',
    size: 10,
    color: 'black',
    rotate: 0
    #z: 10
  )
  count += 1
  end
end

def displayguesses
  #secret_word = "12werer456"
  #pick_random_line().downcase.strip
  #secret_word_array = secret_word.chars.to_a
  correct_guesses = 0
  count = 0
  $secret_word_array.each do |i|
    if $alphabet.include?(i.downcase) == true
      Text.new(
        "_",
      x: $startx + (count * 20),
      y: $starty + 40,
      #font: 'vera.ttf',
      size: 20,
      color: 'black',
      rotate: 0
      #z: 10
    )
    else
      Text.new(
        i.downcase,
      x: $startx + (count * 20),
      y: $starty + 40,
      #font: 'vera.ttf',
      size: 20,
      color: 'black',
      rotate: 0
      #z: 10
    )
      correct_guesses += 1
    end
    count += 1
  end
end

def get_user_input
  until $user_input != ""
    on :key_down do |event|
        $user_input = event.key
    end
  end
end

def display_hanger
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
  #end of base graphics
end

def display_hangman
  on :key_down do |event| #needs to be removed
      $lives -= 1
    case $lives
    when 6
      puts "full lives"
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
  end
  return
end #end display_hangman()

def play
  puts "Generating secret word..."
  $secret_word = pick_random_line().downcase.strip
  $secret_word_array = $secret_word.chars.to_a
  puts "Word generated!\n"
  puts "The secret_word to guess is: #{$secret_word}"
  $alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
  "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  $startx = 20
  $starty = 200
  displayalphabet()
  displayguesses()
  $lives = 6
  $out_of_lives = false
  $letters_remaining = $secret_word.length
  #display_hangman()
  while !$out_of_lives
    #user_input != secret_word and !out_of_guesses
    if $lives > 0
    $user_input = ""

    get_user_input()

      #display_letters_left()
    # puts "Guess a letter: "
    # user_input = gets.chomp.downcase.strip
      until $alphabet.include?($user_input)
         puts "INVALID ENTRY"
         puts "Please guess from the available letters"
         #display_letters_left(alphabet)
         puts "Guess a letter: "
         #user_input = gets.chomp.downcase.strip

      end
      $alphabet.delete($user_input)
    else
      $out_of_lives = true
    end #end if else

    if $secret_word_array.include? $user_input
      #outputBlank = genOutput(secret_word)
      #puts "#{secret_word}"
      #outputCurrent = comparify(user_input, secret_word)
      puts "The secret word contains: #{$user_input}";
      #puts "#{outputBlank}"
      #puts "#{outputCurrent}"
      #user_input.gsub!(/s/, "th")
      #puts "#{secret_word}"
      correct_guesses = 0
      $secret_word_array.each do |x|
        if $alphabet.include?(x.downcase) == true
          print "_ "
        else
          print "#{x.downcase} "
          correct_guesses += 1
        end
      letters_remaining = ($secret_word.length - correct_guesses)
      end
      puts ""
      puts "Letters Remaining: #{$letters_remaining}"

      if correct_guesses == $secret_word.length
        puts "CONGRATULATIONS"
        puts "The word is #{$secret_word}"
        puts "You Win!"
        return
      end #end if
    else
      $lives -= 1
      if $lives > 0
        puts "Oh no, you lost a life!"
      else
        puts "Oh No!"
        puts "The word was #{$secret_word.upcase}"
        puts "Game Over"
      end #end if else
      if $lives > -1
        display_hangman()
      end #end if
    end #end if else

  end #end while

end

def initialize
  display_hanger()
  Text.new(
    'Play',
    x: 10,
    y: 10,
    #font: 'vera.ttf',
    size: 20,
    color: 'black',
    rotate: 0,
    z: 10
  )

  test = Rectangle.new(
    x: 10, y: 10,
    width: 40, height: 25,
    color: 'blue',
    z: 5
  )
  play= Text.new( #delete this
  'Playing',
  x: 50,
  y: 50,
  size: 20,
  color: 'black',
  rotate: 0,
  z: 10
  )
  play.remove
  on :mouse_down do |event|
    # x and y coordinates of the mouse button event
    puts event.x, event.y

    # Read the button event
    if event.x > 0 && event.x < 50 && event.y < 50 && event.y > 0
    case event.button
    when :left
      play.add # RYAN CODE HERE
	     #displayalphabet()
       #displayguesses()
       play()

      puts "play add"
    when :right
      test.remove
    end
    end
  end


  on :mouse_down do |event|
    # x and y coordinates of the mouse button event
    puts event.x, event.y

    # Read the button event
    if event.x > 50 && event.y > 50
    case event.button
    when :left
        play.remove
        puts "rmv play"
    when :right
      test.add
    end
    end
  end

  #quit
  quitbutton = Rectangle.new(
    x: 10, y: 50,
    width: 40, height: 25,
    color: 'red',
    z: 5
  )
  quit = Text.new(
    'quit',
    x: 10,
    y: 50,
    #font: 'vera.ttf',
    size: 20,
    color: 'black',
    rotate: 0,
    z: 10
  )
  on :mouse_down do |event|
    # x and y coordinates of the mouse button event
    puts event.x, event.y

    # Read the button event
    if event.x > 0 && event.x < 50 && event.y < 75 && event.y > 50
    case event.button
    when :left
      close
    end
  end
  end
  #end quit
end

#main

initialize()
show
