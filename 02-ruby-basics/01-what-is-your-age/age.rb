puts "What is your name?"
name = gets.chomp # asks user to type something in the Terminal

puts "Ok got it!"

# TODO: your code goes here
puts "What is your birth year?"
birth_year = gets.chomp.to_i

age = 2019 - birth_year

puts "Thanks. So I guess you're #{age} years old."
