require_relative "BlockArray"
require "test/unit"
 
class TestBlockArray < Test::Unit::TestCase
 
  def test_simple
    #2.2 all?
    assert_equal(['ant', 'bear', 'cat'].all? { |word| word.length >= 3 }, BlockArray.new(['ant', 'bear', 'cat']).all? { |word| word.length >= 3 })
    assert_equal(['ant', 'bear', 'cat'].all? { |word| word.length >= 4 }, BlockArray.new(['ant', 'bear', 'cat']).all? { |word| word.length >= 4 })
    assert_equal([nil, true, 99].all?, BlockArray.new([nil, true, 99]).all?)
    assert_equal([].all?, BlockArray.new([]).all?)
  end 
end