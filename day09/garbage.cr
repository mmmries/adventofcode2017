class Garbage
  @content : String

  getter :content

  def initialize(content)
    @content = content
  end

  def entries
    [] of Garbage | Group
  end

  def garbage_size
    size = 0
    offset = 0
    loop do
      break if offset >= content.size
      if content[offset] == '!'
        offset += 2
      else
        offset += 1
        size   += 1
      end
    end
    size
  end

  def score(depth = 0)
    0
  end

  def string_size
    2 + content.size
  end
end

class Group
  @entries : Array(Garbage | Group)

  getter :entries

  def initialize
    @entries = [] of Garbage | Group
  end

  def content
    ""
  end

  def garbage_size
    entries.reduce(0){|sum, entry| sum + entry.garbage_size }
  end

  def score(depth = 1)
    entries.reduce(depth){|sum, entry| sum + entry.score(depth + 1) }
  end

  def string_size
    size = 2
    if entries.size > 0
      size += entries.size - 1
    end
    entries.reduce(size){|sum, entry| sum + entry.string_size }
  end
end

class Parser
  def self.parse_groups_and_garbage(str, entries = [] of Garbage | Group)
    return entries if str.size == 0
    entry = parse_group_entry(str)
    entries << entry
    offset = entry.string_size
    parse_groups_and_garbage(str[offset..-1], entries)
  end

  def self.parse_garbage(str, content)
    case str[0]
    when '>'
      Garbage.new(content)
    when '!'
      parse_garbage(str[2..-1], content + str[0..1])
    else
      parse_garbage(str[1..-1], content + str[0])
    end
  end

  def self.parse_group(str, group, content)
    case str[0]
    when '}'
      group
    when ','
      parse_group(str[1..-1], group, content)
    else
      entry = parse_group_entry(str)
      group.entries << entry
      offset = entry.string_size
      parse_group(str[offset..-1], group, "")
    end
  end

  def self.parse_group_entry(str)
    case str[0]
    when '<'
      parse_garbage(str[1..-1], "")
    when '{'
      parse_group(str[1..-1], Group.new, "")
    else
      raise "unexpected: #{str[0]}"
    end
  end
end
