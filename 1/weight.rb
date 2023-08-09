loop do
  print "Ваше имя: "
  name = gets.chomp
  print "Ваш рост: "
  height = gets.chomp

  good_weight = (height.to_i - 110) * 1.15

  puts "#{name.capitalize} - для вас идеальный вес: ~ #{good_weight.to_i} кг."

end
