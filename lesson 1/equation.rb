puts "Введите a: "
a = STDIN.gets.chomp
puts "Введите b: "
b = STDIN.gets.chomp
puts "Введите c: "
c = STDIN.gets.chomp

D = b.to_i**2 - 4 * a.to_i * c.to_i

puts "Дискриминант равен: #{D}"

if D < 0
  puts "Нет корней" #P.S если не учитывать комплексные числа
elsif D == 0
  x1 = (-1 * b.to_i) / (2 * a.to_i)
  puts "Уравнение имеет всего один корень:"
  puts "x1,2 = #{x1.to_s}"
else
  x1 = ((-1 * b.to_i) + Math.sqrt(D)) / (2 * a.to_i)
  x2 = ((-1 * b.to_i) - Math.sqrt(D)) / (2 * a.to_i)
  puts "Корни уравнения:"
  puts "x1 = #{x1}, x2 = #{x2}"
end
