assert 'test compression' do
  builder = Mrouter::Builder.new

  builder.add_route '/abc(/:id)/abc', 'tag'

  trie = Mrouter::StaticNode.new('/abc/')
  child_a = trie.add_child Mrouter::DynamicNode.new('id')
  child_a = child_a.add_child Mrouter::StaticNode.new('/abc')
  child_b = trie.add_child Mrouter::StaticNode.new('abc')

  child_a.params = {tag: 'tag'}
  child_b.params = {tag: 'tag'}

  compressed = Mrouter::Compressor.new(builder.trie).compress!
  assert_equal trie, compressed
end

assert 'test multiple routes compression' do
  builder = Mrouter::Builder.new

  builder.add_route '/abc', 'tag_a'
  builder.add_route '/abc/abc', 'tag_b'

  trie = Mrouter::StaticNode.new('/abc')
  trie.params = {tag: 'tag_a'}

  child = trie.add_child Mrouter::StaticNode.new('/abc')
  child.params = {tag: 'tag_b'}

  compressed = Mrouter::Compressor.new(builder.trie).compress!
  assert_equal trie, compressed
end