class Mrouter
  class Compressor
    def initialize trie
      @trie = trie
    end

    def compress_node node
      child = node.children.first
      if node.static? && node.children.size == 1 && child.static? && node.params.nil?
        node.value += child.value
        node.children.replace child.children
        node.params = child.params
        compress_node node
      else
        node.children.each{|child| compress_node child}
      end
    end

    def compress!
      compress_node @trie
      @trie
    end
  end
end