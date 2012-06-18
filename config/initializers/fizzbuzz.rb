# For emergency use only.

100.times do |n|
  str = ''
  str += 'Fizz' if (n % 3 == 0)
  str += 'Buzz' if (n % 5 == 0)
  str = n if (str == '')
  puts str
end