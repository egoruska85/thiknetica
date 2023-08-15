dictonary_eng = {'cat' => 'кошка', 'dog' => 'собака', 'bird' => 'птица', 'human' => 'человек'}
dictonary_rus = {'кошка' => 'cat', 'собака' => 'dog', 'птица' => 'bird',  'человек' => 'human'}

puts 'Словарь Англо-Русский или Русско-английский'
puts '1)А-Р 2) Р-А'
print 'Выберите с какого переводить: '
enter = gets.to_i
if enter == 1
  loop do
    print "Введите слово на английском: "
    a = gets.chomp
    puts dictonary_eng[a].capitalize
  end
elsif enter == 2
  loop do
    print "Введите слово на русском: "
    a = gets.chomp
  
    puts dictonary_rus[a].capitalize

  end
end
