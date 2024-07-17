# frozen_string_literal: true

require_relative 'lib/hash_map'

hash_map = HashMap.new

names = %w[
  Bob
  Mary
  Tom
  Jerry
  Paul
  Francis
  Jim
  Carlos
  Stephanie
  Thomas
  Frank
  Jake
  Mia
]

puts '#set(key, value):'
names.each_with_index { |name, index| hash_map.set(name, index + 1) }
puts hash_map

puts "\n#get(key):"
puts "Entry found . . . . . . 'Mary': #{hash_map.get 'Mary'}"
puts "Entry in LinkedList . . 'Thomas': #{hash_map.get 'Thomas'}"
puts "Entry NOT found . . . . 'Susan': #{hash_map.get 'Susan'}"

puts "\n#has?(key)"
puts "Entry found . . . . . . . 'Carlos': #{hash_map.has? 'Carlos'}"
puts "Entry in LinkedList . . . 'Frank': #{hash_map.has? 'Frank'}"
puts "Entry NOT found . . . . . 'Robert': #{hash_map.has? 'Robert'}"

puts "\n#remove(key):"
puts "#length(): #{hash_map.length}"
puts "Entry found . . . . . . 'Mary': #{hash_map.remove 'Mary'}"
puts "Entry in LinkedList . . 'Stephanie': #{hash_map.remove 'Stephanie'}"
puts "Entry NOT found . . . . 'Susan': #{hash_map.remove 'Susan'}"
puts "#length(): #{hash_map.length}"
puts hash_map

puts "\n#keys()"
p hash_map.keys

puts "\n#values()"
p hash_map.values

puts "\n#entries()"
p hash_map.entries

puts "\n#clear():"
hash_map.clear
puts "#length(): #{hash_map.length}"
puts hash_map
