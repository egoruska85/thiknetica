puts "Enter string"
str = gets.chomp
puts "Enter methods"
method = gets.chomp.to_sym
puts str.send(method)
