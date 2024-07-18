# frozen_string_literal: true

require_relative 'linked_list'

# Collection of key, value pairs where the keys are converted to hash codes for entry and retrieval.
class HashMap
  attr_reader :length

  def initialize
    @buckets = Array.new 16
    @length = 0
    @load_factor = 0.75
  end

  def set(key, value)
    if has? key
      update_entry(key, value)
    else
      double_buckets_size if ((length + 1.0) / @buckets.size) > @load_factor
      add_entry(key, value)
    end
    [key, value]
  end

  def get(key)
    entry = @buckets[hash key]

    return nil if entry.nil?
    return entry.contains?(key) ? entry.value_by_key(key) : nil if entry.is_a?(LinkedList)
    return entry.last if entry.first == key

    nil
  end

  def has?(key)
    return true if keys.include? key

    false
  end

  def remove(key)
    return nil unless has? key

    value = get key
    hash_code = hash key
    bucket = @buckets[hash_code]

    bucket.is_a?(LinkedList) ? bucket.remove_by_key(key) : add_to_buckets(hash_code, nil)

    @length -= 1
    value
  end

  def clear
    size = @buckets.size
    @buckets.clear
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
    @buckets.each_with_object([]) do |entry, array|
      next if entry.nil?

      entry.is_a?(LinkedList) ? entry.each { |node| array << [node.key, node.value] } : array << entry
    end
  end

  def to_s
    string = ''
    @buckets.each_with_index { |entry, index| string += "#{index}: #{entry}\n" }
    string
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % @buckets.size
  end

  def double_buckets_size
    key_value_pairs = entries
    clear
    @buckets = Array.new(@buckets.size * 2)
    key_value_pairs.each { |pair| set(pair.first, pair.last) }
  end

  def add_entry(key, value)
    hash_code = hash key
    bucket = @buckets[hash_code]

    if bucket.nil?
      add_to_buckets(hash_code, [key, value])
    elsif bucket.is_a? LinkedList
      bucket.append key, value
    else
      add_to_buckets(hash_code, new_list(key, value))
    end

    @length += 1
  end

  def update_entry(key, value)
    bucket = @buckets[hash key]
    bucket.is_a?(LinkedList) ? bucket.update_value(key, value) : bucket[1] = value
  end

  def add_to_buckets(index, entry)
    raise IndexError if index.negative? || index >= @buckets.size

    @buckets[index] = entry
  end

  def new_list(key, value)
    list = LinkedList.new
    current_entry = @buckets[hash key]
    list.append current_entry.first, current_entry.last
    list.append key, value
    list
  end
end
