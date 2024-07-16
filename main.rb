# frozen_string_literal: true

require_relative 'lib/hash_map'

hash_map = HashMap.new

puts 'set():'
hash_map.set('Bob', 1)
hash_map.set('Mary', 2)
hash_map.set('Tom', 3)
hash_map.set('Jerry', 4)
hash_map.set('Paul', 5)
hash_map.set('Francis', 6)
hash_map.set('Jim', 7)
hash_map.set('Carlos', 8)
hash_map.set('Stephanie', 9)
hash_map.set('Thomas', 10)
hash_map.set('Frank', 11)
hash_map.set('Jake', 12)
hash_map.set('Mia', 13)

puts hash_map

puts "\nget():"
puts "Entry found . . . . . . get('Mary'): #{hash_map.get('Mary')}"
puts "Entry in LinkedList . . get('Thomas'): #{hash_map.get('Thomas')}"
puts "Entry NOT found . . . . get('Susan'): #{hash_map.get('Susan')}"
puts "\nget() all entries:"
p hash_map.get('Bob')
p hash_map.get('Mary')
p hash_map.get('Tom')
p hash_map.get('Jerry')
p hash_map.get('Paul')
p hash_map.get('Francis')
p hash_map.get('Jim')
p hash_map.get('Carlos')
p hash_map.get('Stephanie')
p hash_map.get('Thomas')
p hash_map.get('Frank')
p hash_map.get('Jake')
p hash_map.get('Mia')
