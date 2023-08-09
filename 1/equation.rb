print "Введите a:"
a = gets.chomp
print "Введите b:"
b = gets.chomp
print "Введите c:"
c = gets.chomp

puts "#{a}x2 - #{b}x + #{c} = 0"

puts "Решение"
puts "D = #{ d = b.to_i ** 2 - 4 * a.to_i * c.to_i }"



if d > 0
  puts "Дискриминант больше 0 и имеет два корня"
  puts "Решение"
  puts "#{ (b.to_i + Math.sqrt(d)) / (2 * a.to_i) } - X1"
  puts "#{ (b.to_i - Math.sqrt(d)) / (2 * a.to_i) } - X2"
elsif d == 0
  puts "Дискриминант равен 0 и имеет один корень"
  puts "Решение"
  puts "#{ b.to_i / (2 * a.to_i) }"

elsif d < 0
  puts "Дискриминант меньше 0 и не имеет корней"

end
