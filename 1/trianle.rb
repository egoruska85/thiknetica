print "Введите A:"
a = gets.chomp
print "Введите B:"
b = gets.chomp
print "Введите C:"
c = gets.chomp



if a == b and a != c
  puts "Треугольник равнобедренный"
elsif a == c and a != b
  puts "Треугольник равнобедренный"
elsif a == b and a == c and b == c
  puts "Треугольник равносторонний"
end
puts "Решение"
puts "#{a} ** 2(#{ a.to_i ** 2 }) + #{b} ** 2(#{ b.to_i ** 2 }) = (#{a.to_i ** 2 + b.to_i ** 2})"
