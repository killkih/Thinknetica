letters = {}
value = 1
('A'..'Z').each do |letter|
  if 'AEIOUY'.include?(letter)
    letters[letter] = value
  end
  value += 1
end
puts letters
