input = File.open("baza_productov.txt", "r")
hash = {}
while line = input.gets
  array = line.split(', ')

  a = array[0].to_i
  b = array[1]
  c = array[2]



  hash[a] = [b, c.to_i]


end
puts hash

position = 0

basket = {}

total = 0


puts "Прогамма не работает без файла базы (baza_productov.txt)"
while true
  quantity = 0

  print "Введите код товара('/' Оплата):"
  code = gets.chomp

if code != '/'

  position += 1


  product = hash[code.to_i]



  basket[position] = [code.to_i, product, quantity += 1]

  total = total + product[1]



  puts "#{basket} Итог покупок: #{total} рублей"


elsif code == '/'
    puts "Ваша корзина составляет на сумму #{total} - содержание корзины #{basket}"
    break

  end
end
