require_relative 'exceptions'
require_relative 'node'
require 'pry'

class LinkedList
  attr_accessor :head
  attr_reader :length

  def initialize
    @head = nil
    @length = 0
  end

  # append to tail
  def add(element)
    new_node = Node.new(element)

    if head == nil
      self.head = new_node
    else
      tail.next = new_node
    end

    self.length += 1
    element
  end

  def get(index)
    result = iterate do |node, i|
      return node.element if i == index
    end

    raise_no_such_element_error(index) if result.nil?
  end

  def set(index, element)
    result = iterate do |node, i|
      return node.element = element if i == index
    end

    raise_no_such_element_error(index) if result.nil?
  end

  def first
    raise_no_such_element_error(0) if length == 0

    head.element
  end

  def last
    raise_no_such_element_error(length) if length == 0

    tail.element
  end

  def insert(index, element)
    raise OutOfBoundsError if (index < 0 || index >= length) && index != 0

    new_node = Node.new(element)

    if index == 0
      new_node.next = head
      self.head = new_node
    else
      # allocate nodes before & after insertion
      node_before = retrieve_node(index-1)
      node_after = node_before.next
      # assign nodes to new references
      node_before.next = new_node
      new_node.next = node_after
    end

    self.length += 1
    element
  end

  def find(element)
    found = iterate do |node, i|
      return node.element if node.element == element
    end

    raise_no_element_found_error(element) if found.nil?
  end

  private

  attr_writer :length

  def retrieve_node(index)
    iterate do |node, i|
      return node if i == index
    end
  end

  # how does yield/block change time complexity?
  def iterate
    current_node = self.head
    i = 0

    while current_node != nil
      yield(current_node, i)
      current_node = current_node.next
      i += 1
    end
  end

  def tail
    # if empty?
    iterate do |node, i|
      return node if i == length-1
    end
  end

  def raise_no_such_element_error(index)
    raise NoSuchElementError.new("No such element at index #{index}.")
  end

  def raise_no_element_found_error(element)
    raise NoElementFound.new("The element #{element} was not found.")
  end

end
