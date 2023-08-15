month = {'31' => ['Январь', 'Март', 'Май', 'Июль', 'Август', 'Октябрь', 'Декабрь'], '30' => ['Апрель', 'Июнь', 'Сентябрь', 'Ноябрь'], '28' => 'Февраль', '29' => 'Февраль - раз в 4 года'  }
print = 'Введите количество дней:'
enter = gets.chomp

a = 0
if enter == '28' or enter == '29'
  puts "1) - #{month[enter]} - #{enter} дней"
else
  month[enter].each do |month|
    a += 1
    puts "#{a}) - #{month} - #{enter} дней"
  end
end
