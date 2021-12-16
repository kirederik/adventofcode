class Element
  include Comparable
  attr_accessor :name, :priority

  def initialize(node, priority)
    @node, @priority = node, priority
  end

  def <=>(other)
    @priority <=> other.priority
  end

  def node
    @node
  end
end

class SimplePriorityQueue
  def initialize
    @elements = []
  end

  def <<(element)
    @elements << element
  end

  def pop
    last_element_index = @elements.size - 1
    @elements.sort!
    @elements.delete_at(last_element_index)
  end

  def size
    @elements.size
  end

  def any?
    @elements.any?
  end
end
