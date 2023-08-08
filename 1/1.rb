print "Как Вас зовут: "
name = gets.chomp

print "В каком году ты родились: "
year = gets.chomp


puts "#{name}, привет Добро пожаловать на курсы Thinknetica! Вам примерно #{ 2023 - year.to_i }"
