# frozen_string_literal: true

require_relative 'lib/hash_map'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts
puts test

test.set('apple', 'rose')
test.set('dog', 'chocolate')
test.set('jacket', 'sky')

puts
puts test

test.set('moon', 'silver')

puts
puts test

test.set('apple', 'red')
test.set('dog', 'brown')
test.set('jacket', 'blue')

puts
puts test

puts
puts test.get 'kite'

puts
puts test.has? 'lion'
puts test.has? 'ice cream'

puts
p test.entries
p test.keys
p test.values

puts
puts test.has? 'frog'
puts test.has? 'dog'
puts test.length
puts test.remove 'frog'
puts test.length
puts test.remove 'dog'
puts test.length
puts test.has? 'frog'
puts test.has? 'dog'

puts
puts test.length
p test.entries
puts test.clear
p test.entries
