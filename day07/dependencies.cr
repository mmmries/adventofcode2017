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

  def add(node)
    if @root.nil?
      @root = node
    end
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
end
