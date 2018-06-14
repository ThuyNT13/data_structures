require 'pry'

class Node
  attr_accessor :next, :element

  def initialize(element)
    @element = element
    @next = nil
  end

end
