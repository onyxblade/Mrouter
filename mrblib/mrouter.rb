class Mrouter
  def initialize
    @compressed = false
    @builder = Builder.new
  end

  def add_route path, params
    raise "cannot add route after first match" if @compressed
    @builder.add_route path, params
  end

  def compress
    @trie = @builder.trie
    Compressor.new(@trie).compress!
    @matcher = Matcher.new(@trie)
    @compressed = true
  end

  def match path
    compress unless @compressed
    @matcher.match path
  end
end