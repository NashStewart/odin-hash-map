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
    hash_code = hash(key)
    bucket = entries[hash_code]

    if bucket.nil?
      @entries[hash_code] = [key, value]
    elsif bucket.is_a? LinkedList
      bucket.append key, value
    else
      @entries[hash_code] = new_list(hash_code, key, value)
    end

    [key, value]
  end

  def get(key)
    hash_code = hash(key)
    entry = entries[hash_code]

    return nil if entry.nil?
    return entry.contains?(key) ? entry.value_by_key(key) : nil if entry.is_a?(LinkedList)
    return entry.last if entry.first == key

    nil
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
    hash_code % entries.size
  end

  def new_list(hash_code, key, value)
    list = LinkedList.new
    current_entry = entries[hash_code]
    list.append current_entry.first, current_entry.last
    list.append key, value
    list
  end
end
