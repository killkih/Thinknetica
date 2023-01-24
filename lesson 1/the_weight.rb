puts "Как вас зовут?"
name = STDIN.gets.chomp

puts "Какой у вас рост?"
height = STDIN.gets.chomp

result = (height.to_i - 110) * 1.15

if result < 0
  puts "Ваш вес уже оптимальный"
else
  puts "#{name}, ваш идеальный вес - #{result} кг!"
end
