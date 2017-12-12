class Dependencies
  def self.parse(filepath)
    parsed = {} of String => Node
    ::File.read(filepath).chomp.split("\n").each do |line|
      match = line.match(/(\w+)\s+\((\d+)\)\s*-?>?\s*([\w\s,]*)$/)
      raise "can't parse line :: #{line}" if match.nil?
      child_names = [] of String
      if match[3] && match[3].bytesize > 0
        child_names = match[3].split(", ")
      end
      parsed[match[1]] = Node.new(match[1], match[2].to_i, child_names)
    end

    root_node = find_root_node(parsed)
    raise "could not find root node in #{parsed}" if root_node.nil?
    assemble_children(root_node, parsed)
    Dependencies.new(root_node)
  end

  def self.find_root_node(parsed)
    entry = parsed.find do |name, node|
      parent_entry = parsed.find{|_other_name, other_node| other_node.child_names.includes?(name) }
      parent_entry.nil?
    end
    return nil if entry.nil?
    entry.last
  end

  def self.assemble_children(node, node_hash)
    node.child_names.each do |name|
      child = node_hash[name]
      node.children << child
      assemble_children(child, node_hash)
    end
  end

  @root : Node
  getter :root

  def initialize(root)
    @root = root
  end

  def imbalanced_nodes(node = nil)
    node ||= root
    imbalanced = node.children.flat_map{|child| imbalanced_nodes(child).as(Array(Node)) }
    if node.imbalanced?
      imbalanced << node
    end
    imbalanced
  end
end

class Node
  @child_names : Array(String)
  @name : String
  @weight : Int32
  getter :children, :child_names, :name, :weight

  def initialize(@name, @weight, @child_names)
    @children = [] of Node
  end

  def imbalanced?
    child_weights = children.map{|node| node.total_weight }
    child_weights.any?{|weight| child_weights.find{|other_weight| weight != other_weight } }
  end

  def print(prefix = "")
    puts "#{prefix}#{name} -> (#{weight}/#{total_weight})"
    children.each do |child|
      child.print(prefix + "  ")
    end
  end

  def total_weight
    weight_of_children = children.map{|node| node.total_weight.as(Int32) }.reduce(0){|sum, total_weight| sum + total_weight }
    weight + weight_of_children
  end
end
