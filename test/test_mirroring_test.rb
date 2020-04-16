# frozen_string_literal: true

require 'minitest/autorun'
require 'mirroring_test'

class TestMirroringTest < Minitest::Test
  def test_reply
    a = [1, 2, 3]
    b = [4]

    mt = MirroringTest.new(a, b)

    assert_equal(3, mt.size)
  end

  def test_block
    a = [1, 2, 3]
    b = [4, 5, 6]

    mt = MirroringTest.new(a, b)
    mt.map! { |e| e * e }

    assert_equal([1, 4, 9], a)
    assert_equal([16, 25, 36], b)
  end

  def test_defined_method_calling
    a = []

    mt = MirroringTest.new(a)

    assert_equal(true, mt.respond_to?(:size))
  end

  def test_unknown_method_calling
    a = []

    mt = MirroringTest.new(a)

    assert_equal(false, mt.respond_to?(:unknown_method))
  end

  def test_class_impersonation
    a = []

    mt = MirroringTest.new(a)

    assert_equal(Array, mt.class)
    assert_equal(true, mt.is_a?(Array))
    assert_equal(true, mt.kind_of?(Array)) # rubocop:disable Style/ClassCheck
    assert_equal(true, mt.instance_of?(Array))
    assert_instance_of(Array, mt)
  end
end
