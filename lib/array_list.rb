require_relative 'fixed_array'
require_relative 'exceptions'

class ArrayList
  attr_accessor :length, :array
  # attr_reader :length, :array

  def initialize
    @array = FixedArray.new(6)
    @length = 0;
  end

  def add(element)
    increase_array_size if array.size == length

    array.set(length,element)

    self.length += 1
    element
  end

  def get(index)
    raise_no_such_element_error(index) if no_element_at?(index)

    array.get(index)
  end

  def set(index, element)
    raise_no_such_element_error(index) if no_element_at?(index)

    array.set(index,element)
  end

  def first
    raise_no_such_element_error(0) if length == 0
    array.get(0)
  end

  def last
    raise_no_such_element_error(length) if length == 0
    array.get(length-1)
  end

  def insert(index, element)
    raise OutOfBoundsError if no_element_at?(index) && index != 0
    increase_array_size if array.size == length

    shift_after(index)

    array.set(index, element)

    self.length += 1
    element
  end

  private
  # attr_writer :array, :length

  def shift_after(index)
    # why won't upto work?
    (length-1).downto(index) { |i| array.set(i+1, array.get(i))}

    array
  end

  def increase_array_size
    # OutOfBoundsError:
    #    The index 6 outside the bounds of this FixedArray of size 6

    size_incr = self.length * 2

    new_array = FixedArray.new(size_incr)

    self.length.times { |i| new_array.set(i, array.get(i))}

    array = new_array

  end

  def no_element_at?(index)
    array.get(index) == nil
  end

  def raise_no_such_element_error(index)
    raise NoSuchElementError.new("No such element at index #{index}.")
  end

end
