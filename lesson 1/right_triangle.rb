sides = []
while sides.length != 3
  puts "Введите сторону треугольника: "
  side = STDIN.gets.chomp
  sides << side.to_i
end

if sides.uniq.length == 1
  puts "Треуголиник является равносторонним"
elsif sides.uniq.length == 2
  puts "Треугольник является равнобедренным"
end

# Найдём гипотенузу и отрежем её от массива, тогда у нас останется 2 катета
c = sides.max
sides.delete(c.to_i)

if c == Math.sqrt(sides[0]**2 + sides[1]**2)
  puts "Треугольник является прямоугольным"
end
