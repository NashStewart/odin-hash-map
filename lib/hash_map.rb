# frozen_string_literal: true

# Collection of key, value pairs where the keys are converted to hash codes for entry and retrieval.
class HashMap
  attr_reader :entries

  def initialize
    @entries = Array.new 16
    @load_factor = 0.75
  end

  def set(key, value)
    hash_code = hash(key) % entries.size
    @entries[hash_code] = [key, value]
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end
end
