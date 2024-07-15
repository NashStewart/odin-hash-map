# frozen_string_literal: true

require_relative 'lib/hash_map'

hash_map = HashMap.new

hash_map.set('Bob', 1)
hash_map.set('Mary', 2)
hash_map.set('Tom', 3)
hash_map.set('Jerry', 4)
hash_map.set('Paul', 5)
hash_map.set('Francis', 6)
hash_map.set('Jim', 7)
hash_map.set('Carlos', 8)

p hash_map.entries
