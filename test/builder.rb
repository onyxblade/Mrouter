
assert 'test static nodes' do
  builder = Mrouter::Builder.new
  assert_kind_of Mrouter::TrieNode, builder.trie

  tag = 'tag'
  builder.add_route '/abc', tag

  trie = Mrouter::StaticNode.new('')
  child = trie.add_child Mrouter::StaticNode.new('/')
  child = child.add_child Mrouter::StaticNode.new('a')
  child = child.add_child Mrouter::StaticNode.new('b')
  child = child.add_child Mrouter::StaticNode.new('c')
  child.tag = tag

  assert_equal trie, builder.trie
end

assert 'test dynamic nodes' do
  builder = Mrouter::Builder.new

  tag = 'tag'
  builder.add_route '/abc(/:id(.:format))/abc', tag

  trie = Mrouter::StaticNode.new('')
  child = trie.add_child Mrouter::StaticNode.new('/')
  child = child.add_child Mrouter::StaticNode.new('a')
  child = child.add_child Mrouter::StaticNode.new('b')
  child = child.add_child Mrouter::StaticNode.new('c')

  child_a = child.add_child Mrouter::StaticNode.new('/')
  child_b = child_a

  child_a = child_a.add_child Mrouter::DynamicNode.new('id')

  child_c = child_a.add_child Mrouter::StaticNode.new('.')
  child_c = child_c.add_child Mrouter::DynamicNode.new('format')
  child_c = child_c.add_child Mrouter::StaticNode.new('/')

  child_a = child_a.add_child Mrouter::StaticNode.new('/')

  [child_a, child_b, child_c].each do |child|
    child = child.add_child Mrouter::StaticNode.new('a')
    child = child.add_child Mrouter::StaticNode.new('b')
    child = child.add_child Mrouter::StaticNode.new('c')
    child.tag = tag
  end

  assert_equal trie, builder.trie
end

assert 'test multiple routes' do
  builder = Mrouter::Builder.new

  builder.add_route '/abc(/:id)/abc', 'tag_a'
  builder.add_route '/abc(/:id)/abd', 'tag_b'

  trie = Mrouter::StaticNode.new('')
  child = trie.add_child Mrouter::StaticNode.new('/')
  child = child.add_child Mrouter::StaticNode.new('a')
  child = child.add_child Mrouter::StaticNode.new('b')
  child = child.add_child Mrouter::StaticNode.new('c')
  child = child.add_child Mrouter::StaticNode.new('/')

  child_a = child.add_child Mrouter::DynamicNode.new('id')
  child_a = child_a.add_child Mrouter::StaticNode.new('/')
  child_b = child

  [child_a, child_b].each do |child|
    child = child.add_child Mrouter::StaticNode.new('a')
    child = child.add_child Mrouter::StaticNode.new('b')
    leaf_a = child.add_child Mrouter::StaticNode.new('c')
    leaf_b = child.add_child Mrouter::StaticNode.new('d')
    leaf_a.tag = 'tag_a'
    leaf_b.tag = 'tag_b'
  end

  assert_equal trie, builder.trie
end