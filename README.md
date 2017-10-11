# Mrouter
A mini router for mruby and mri, uses trie for matching.

# Usage
```ruby
router = Mrouter.new
router.add_route '/resource(/:id(.:format))', {action: 'example'}

router.match '/resource' # => {:action=>"example"}
router.match '/resource/123.pdf' # => {:id=>"123", :format=>"pdf", :action=>"example"}
```
# Pattern format

* `string` for exact string matching
* `()` for optional matching
* `:capture` for capture, stops at `/`, `.`

# Handle HTTP methods

Simply prefix the http method to the path, like:
```ruby
router.add_route 'get /resource(/:id(.:format))', {method: 'GET', action: 'example'}
```

This gem only handle paths, not queries. You can use ngx_mruby's built-in Request or URI to process queries.

Route definitions are case sensitive. `downcase` before match when necessary.

# Testing

Include this gem at the test build section of `build_config.rb`, then use mruby's `make test`.

# License

[The MIT License](https://opensource.org/licenses/MIT)
