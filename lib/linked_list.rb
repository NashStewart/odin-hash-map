# frozen_string_literal: true

require_relative 'node'

# Collection of Node objects that each point to the next Node in the list.
class LinkedList
  attr_reader :head, :size, :tail

  def initialize
    @size = 0
  end

  def append(value)
    new_node = Node.new value
    if head
      tail.next_node = new_node
    else
      @head = new_node
    end
    @tail = new_node
    @size += 1
    new_node
  end

  def prepend(value)
    new_node = Node.new value, head
    @head = new_node
    @size += 1
    new_node
  end

  def at(index)
    return nil unless index_in_bounds? index

    node = head
    index.times do
      node = node.next_node
    end
    node
  end

  def pop
    last = tail
    second_to_last = at(size - 2)
    second_to_last.delete_next
    @size -= 1
    @tail = second_to_last
    last
  end

  def contains?(value)
    each { |node| return true if node.value == value }
    false
  end

  def find(value)
    each_with_index do |node, index|
      return index if node.value == value
    end
    nil
  end

  def to_s
    string = ''
    each { |node| string += "( #{node.value} ) -> " }
    string += 'nil'
    string
  end

  def insert_at(value, index)
    return nil unless index_in_bounds? index
    return prepend(value) if index.zero?
    return append(value) if index == size

    previous_node = at index - 1
    current_node = previous_node.next_node
    new_node = Node.new value, current_node
    previous_node.next_node = new_node
    @size += 1
    new_node
  end

  def shift
    node_to_remove = head
    @head = node_to_remove.next_node
    @size -= 1
    node_to_remove
  end

  def remove_at(index)
    return nil unless index_in_bounds? index
    return pop if index == size - 1
    return shift if index.zero?

    previous_node = at index - 1
    node_to_remove = previous_node.next_node
    next_node = node_to_remove.next_node
    previous_node.delete_next
    previous_node.next_node = next_node
    @size -= 1
    node_to_remove
  end

  def each
    each_with_index { |node, _| yield node }
  end

  def each_with_index
    node = head
    size.times do |index|
      yield node, index
      node = node.next_node
    end
  end

  private

  def index_in_bounds?(index)
    index >= 0 && index < size
  end
end
