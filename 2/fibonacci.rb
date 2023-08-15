array = [0, 1]
start = 0
step = 1
while step < 100

  array << (array[-2] + array[-1])
  step = array.last
end
array.delete(144)
puts array.inspect
