months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31,
  9 => 30, 10 => 31, 11 => 30, 12 => 31 }
index = 0

puts "Введите день: "
day = STDIN.gets.chomp.to_i
puts "Введите месяц: "
month = STDIN.gets.chomp.to_i
puts "Введите год: "
year = STDIN.gets.chomp.to_i

if month > 1
  if year & 100 == 0 && year % 400 == 00
    index =+ 1
  elsif year % 4 == 0
    index += 1
  end
end

while month > 0 do
  month -= 1
  index += months[month].to_i
end

puts index + day


