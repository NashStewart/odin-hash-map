# frozen_string_literal: true

require_relative 'linked_list'

# Collection of key, value pairs where the keys are converted to hash codes for entry and retrieval.
class HashMap
  attr_reader :entries, :length

  def initialize
    @entries = Array.new 16
    @length = 0
    @load_factor = 0.75
  end

  def set(key, value)
    bucket = entries[hash key]

    if bucket.nil?
      @entries[hash key] = [key, value]
    elsif bucket.is_a? LinkedList
      bucket.append key, value
    else
      @entries[hash key] = new_list(key, value)
    end

    @length += 1
    [key, value]
  end

  def get(key)
    entry = entries[hash key]

    return nil if entry.nil?
    return entry.contains?(key) ? entry.value_by_key(key) : nil if entry.is_a?(LinkedList)
    return entry.last if entry.first == key

    nil
  end

  def has?(key)
    return true unless get(key).nil?

    false
  end

  def remove(key)
    return nil unless has? key

    value = get key
    bucket = entries[hash key]

    if bucket.is_a? LinkedList
      bucket.remove_by_key key
    else
      @entries[hash key] = nil
    end

    @length -= 1
    value
  end

  def clear
    size = entries.size
    entries.clear
    @entries = Array.new size
    @length = 0
  end

  def keys
    entries.each_with_object([]) do |entry, array|
      unless entry.nil?
        if entry.is_a? LinkedList
          array.concat entry.keys
        else
          array << entry.first
        end
      end
    end
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

  def new_list(key, value)
    list = LinkedList.new
    current_entry = entries[hash key]
    list.append current_entry.first, current_entry.last
    list.append key, value
    list
  end
end
