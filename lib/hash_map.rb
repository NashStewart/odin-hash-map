# frozen_string_literal: true

require_relative 'linked_list'

# Collection of key, value pairs where the keys are converted to hash codes for entry and retrieval.
class HashMap
  attr_reader :buckets, :length

  def initialize
    @buckets = Array.new 16
    @length = 0
    @load_factor = 0.75
  end

  def set(key, value)
    bucket = buckets[hash key]

    if bucket.nil?
      @buckets[hash key] = [key, value]
    elsif bucket.is_a? LinkedList
      bucket.append key, value
    else
      @buckets[hash key] = new_list(key, value)
    end

    @length += 1
    [key, value]
  end

  def get(key)
    entry = buckets[hash key]

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
    bucket = buckets[hash key]

    if bucket.is_a? LinkedList
      bucket.remove_by_key key
    else
      @buckets[hash key] = nil
    end

    @length -= 1
    value
  end

  def clear
    size = buckets.size
    buckets.clear
    @buckets = Array.new size
    @length = 0
  end

  def keys
    entries.map(&:first)
  end

  def values
    entries.map(&:last)
  end

  def entries
    buckets.each_with_object([]) do |entry, array|
      next if entry.nil?

      if entry.is_a? LinkedList
        array.concat entry.key_value_pairs
      else
        array << entry
      end
    end
  end

  def to_s
    string = ''
    buckets.each_with_index { |entry, index| string += "#{index}: #{entry}\n" }
    string
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % buckets.size
  end

  def new_list(key, value)
    list = LinkedList.new
    current_entry = buckets[hash key]
    list.append current_entry.first, current_entry.last
    list.append key, value
    list
  end
end
