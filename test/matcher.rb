assert 'match path' do
  route = '/abc(/:id(.:format))'

  builder = Mrouter::Builder.new
  builder.add_route route, 'tag'
  compressed = Mrouter::Compressor.new(builder.trie).compress!

  builder = Mrouter::Builder.new
  builder.add_route route, 'tag'

  path = '/abc/123.pdf'
  expected = {id: '123', format: 'pdf', tag: 'tag'}
  assert_equal expected, Mrouter::Matcher.new(builder.trie).match(path)
  assert_equal expected, Mrouter::Matcher.new(compressed).match(path)

  path = '/abc/123'
  expected = {id: '123', tag: 'tag'}
  assert_equal expected, Mrouter::Matcher.new(builder.trie).match(path)
  assert_equal expected, Mrouter::Matcher.new(compressed).match(path)

  path = '/abc/'
  expected = {tag: 'tag'}
  assert_equal expected, Mrouter::Matcher.new(builder.trie).match(path)
  assert_equal expected, Mrouter::Matcher.new(compressed).match(path)

  path = '/ab'
  assert_false Mrouter::Matcher.new(builder.trie).match(path)
  assert_false Mrouter::Matcher.new(compressed).match(path)
end