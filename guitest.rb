#Hangman gui test



require 'ruby2d'
set background: 'white'
lives = 7
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

alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
"l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
startx = 40
starty = 200
count = 0
alphabet.each do |i|
  Text.new(
    i,
  x: startx + (count * 10),
  y: starty,
  #font: 'vera.ttf',
  size: 10,
  color: 'black',
  rotate: 0
  #z: 10
)
count += 1
end

secret_word = "12werer456"
#pick_random_line().downcase.strip
secret_word_array = secret_word.chars.to_a
correct_guesses = 0
count = 0
secret_word_array.each do |i|
  if alphabet.include?(i.downcase) == true
    Text.new(
      "_",
    x: startx + (count * 20),
    y: starty + 40,
    #font: 'vera.ttf',
    size: 20,
    color: 'black',
    rotate: 0
    #z: 10
  )
  else
    Text.new(
      i.downcase,
    x: startx + (count * 20),
    y: starty + 40,
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

on :mouse_down do |event|
  # x and y coordinates of the mouse button event
  puts event.x, event.y

  # Read the button event
  case event.button
  when :left
    Text.new(
      'Playing',
      x: 20,
      y: 40,
      size: 20,
      color: 'black',
      rotate: 0,
      z: 10
    )
  end
end
    # Left mouse button pressed down


#set up hang


#head

  on :key_down do |event|
    if lives > 5
      update do
      Circle.new(
          x: 320, y: 150,
          radius: 30,
          sectors: 32,
          color: 'black',
          z: 1
  )
end
end
puts lives
lives -=1
end




#body
on :key_down do |event|
  if lives == 5
  update do
Line.new(
x1:320, y1: 150,
x2:320, y2: 240,
color: 'black',
width: 20,
z:10
)
end
end
end


#arm1
on :key_down do |event|
  if lives == 4
  update do
Line.new(
x1:320, y1: 150,
x2:290, y2: 240,
color: 'black',
width: 12.5,
z:10
)
end
end
end

#arm2
on :key_down do |event|
  if lives == 3
  update do
Line.new(
x1:320, y1: 150,
x2:350, y2: 240,
color: 'black',
width: 12.5,
z:10
)
end
end
end


#leg1
  on :key_down do |event|
    if lives ==2
    update do
  Line.new(
  x1:320, y1: 240,
  x2:290, y2: 330,
  color: 'black',
  width: 12.5,
  z:10
  )
  end
  end
  end


#leg2
on :key_down do |event|
  if lives == 1
  update do
Line.new(
x1:320, y1: 240,
x2:350, y2: 330,
color: 'black',
width: 12.5,
z:10
)

end
end
end

show
