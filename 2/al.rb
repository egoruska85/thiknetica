alphabet = {}
value = 0
('a'..'z').each do |key|
  value +=1
  if key == 'a'
    alphabet[key] = value
  elsif key == 'e'
    alphabet[key] = value
  elsif key == 'i'
    alphabet[key] = value
  elsif key == 'o'
    alphabet[key] = value
  elsif key == 'u'
    alphabet[key] = value
  elsif key == 'y'
    alphabet[key] = value
  end
end

puts alphabet
