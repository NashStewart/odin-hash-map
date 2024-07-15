# frozen_string_literal: true

require_relative 'linked_list'

# Collection of key, value pairs where the keys are converted to hash codes for entry and retrieval.
class HashMap
  attr_reader :entries

  def initialize
    @entries = Array.new 16
    @load_factor = 0.75
  end

  def set(key, value)
    hash_code = hash(key) % entries.size
    initial_pair = entries[hash_code]
    new_pair = [key, value]

    if initial_pair.is_a? LinkedList
      initial_pair.append new_pair
    else
      @entries[hash_code] = initial_pair.nil? ? new_pair : new_list(hash_code, new_pair)
    end

    new_pair
  end

  def to_s
    string = ''
    entries.each_with_index { |entry, index| string += "#{index}: #{entry}\n" }
    string
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def new_list(hash_code, key_value_pair)
    list = LinkedList.new
    list.append entries[hash_code]
    list.append key_value_pair
    list
  end
end
