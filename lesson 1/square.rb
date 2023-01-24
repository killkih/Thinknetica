puts "Введите основание треугольника: "
base = STDIN.gets.chomp

puts "Введите высоту треугольника: "
height = STDIN.gets.chomp

result = 0.5 * base.to_i * height.to_i

puts "Площать треугольника: #{result}"
