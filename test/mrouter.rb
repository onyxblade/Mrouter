
assert 'test match' do
  router = Mrouter.new
  router.add_route '/resource(/:id(.:format))', {action: 'example'}
  expected = {id: '123', format: 'pdf', action: 'example'}
  assert_equal expected, router.match('/resource/123.pdf')
end

assert 'cannot add routes after compression' do
  router = Mrouter.new
  router.add_route '/abc', {}
  router.match '/abc'

  assert_raise RuntimeError do
    router.add_route '/abd', {}
  end
end