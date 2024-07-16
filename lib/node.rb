# frozen_string_literal: true

# A key, value pair and reference pointer to the next Node in a LinkedList.
class Node
  attr_reader :key, :value, :next_node

  def initialize(key = nil, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end

  def next_node=(node)
    @next_node = node if node.is_a? Node
  end

  def delete_next
    @next_node = nil
  end

  def to_s
    next_key = next_node.nil? ? 'nil' : next_node.key
    next_value = next_node.nil? ? 'nil' : next_node.value
    "( #{key}, #{value} ) -> #{next_key}, #{next_value}"
  end
end
