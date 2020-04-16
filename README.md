Mirroring Test Gem [![](https://badge.fury.io/rb/mirroring_test.svg)](https://badge.fury.io/rb/mirroring_test) ![](https://github.com/supercaracal/mirroring-test-gem/workflows/CI/badge.svg) ![](https://github.com/supercaracal/mirroring-test-gem/workflows/CD/badge.svg)
=====================

This gem calls a same method for multiple receivers.

```ruby
require 'mirroring_test'

a = [1, 2, 3]
b = [4, 5, 6]

mt = MirroringTest.new(a, b)
mt.map! { |e| e * e }

# a => [1, 4, 9]
# b => [16, 25, 36]
```
