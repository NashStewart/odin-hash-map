# frozen_string_literal: true

# A value and reference pointer to the next Node in a LinkedList.
class Node
  attr_reader :value, :next_node

  def initialize(value = nil, next_node = nil)
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
    next_value = next_node.nil? ? 'nil' : next_node.value
    "( #{value} ) -> #{next_value}"
  end
end
