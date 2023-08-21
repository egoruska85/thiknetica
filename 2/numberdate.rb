days = { '01' => 0, '02' => 31, '03' => 59, '04' => 90, '05' => 120, '06' => 151, '07' => 181, '08' => 212, '09' => 243, '10' => 273, '11' => 304, '12' => 334 }

loop do
  print "Введите дату через точку: "
  enter = gets.chomp

  datetime = enter.split('.')


  date = datetime[0]
  month = datetime[1]
  year = datetime[2]

  v_year = datetime[2].to_i % 4 ### Определение високосного года

  a = days[month].to_i + date.to_i

  if date == '29' and month == '02' and v_year == 0
    puts "#{days[month].to_i + date.to_i}"
  elsif v_year == 0 and a > days['03']
    puts "#{days[month].to_i + date.to_i + 1}"
  elsif v_year == 0
    puts "#{days[month].to_i + date.to_i}"
  elsif v_year != 0
    puts "#{days[month].to_i + date.to_i}"
  end
end
