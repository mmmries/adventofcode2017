class Node
  def self.follow(directions)
    directions.reduce(Node.new(0,0,0)) do |node, direction|
      node.move(direction)
    end
  end

  getter :a, :b, :c
  @a : Int32
  @b : Int32
  @c : Int32

  include Comparable(Node)

  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
    raise ArgumentError.new("invalid location") if (a + b + c) != 0
  end

  def distance_from_origin
    [a.abs, b.abs, c.abs].max
  end

  def move(direction)
    case direction
    when "n"
      Node.new(a+1, b-1, c)
    when "ne"
      Node.new(a+1, b, c-1)
    when "se"
      Node.new(a, b+1, c-1)
    when "s"
      Node.new(a-1, b+1, c)
    when "sw"
      Node.new(a-1, b, c+1)
    when "nw"
      Node.new(a, b-1, c+1)
    else
      raise "invalid direction"
    end
  end

  def <=>(other)
    return 0 if a == other.a && b == other.b && c == other.c
    return -1 if a < other.a
    return 1
  end
end
