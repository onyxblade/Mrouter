module Mrouter
  class TrieNode
    attr_accessor :children, :value, :tag

    def initialize value
      @value = value
      @children = []
    end

    def leaf?
      @children.empty?
    end

    def static?; end
    def dynamic?; end

    def == another
      self.class == another.class && self.children == another.children && self.tag == another.tag
    end
    alias :eql? :==

    def add_child child
      @children << child
      child
    end
  end

  class StaticNode < TrieNode
    def static?
      true
    end
  end

  class DynamicNode < TrieNode
    def dynamic?
      true
    end
  end
end