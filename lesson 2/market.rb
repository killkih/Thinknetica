
products = {}
total_price = 0

loop do
  puts "Введите название товара: "
  product = STDIN.gets.chomp.to_s
  break if product.downcase == "стоп"
  puts "Введите цену за единицу товара: "
  price = STDIN.gets.chomp.to_f
  puts "Введите кол-во этого товара: "
  number = STDIN.gets.chomp.to_f

  products[product] = {'Цена' => price, 'Кол-во' => number}

  system('reset')
end
puts
puts products
puts
products.keys.each do |purchase|
  specific_price = products[purchase].values.reduce(&:*)
  puts "Товар: #{purchase}  - обращая цена за товар: #{specific_price.round(2)}"
  total_price += specific_price.to_f
end
puts
puts "Общая цена покупок: #{total_price.round(2)}"
