require_relative "BlockArray"
require "test/unit"
 
class TestBlockArray < Test::Unit::TestCase
 
  def test_simple
    #2.2 all?
    assert_equal(['ant', 'bear', 'cat'].all? { |word| word.length >= 3 }, BlockArray.new(['ant', 'bear', 'cat']).all? { |word| word.length >= 3 })
    assert_equal(['ant', 'bear', 'cat'].all? { |word| word.length >= 4 }, BlockArray.new(['ant', 'bear', 'cat']).all? { |word| word.length >= 4 })
    assert_equal([nil, true, 99].all?, BlockArray.new([nil, true, 99]).all?)
    assert_equal([].all?, BlockArray.new([]).all?)

    #2.14 flat_map
    assert_equal([1, 2, 3, 4].flat_map { |e| [e, -e] }, BlockArray.new([1, 2, 3, 4]).flat_map { |e| [e, -e] })
    assert_equal([[1, 2], [3, 4]].flat_map { |e| e + [100] }, BlockArray.new([[1, 2], [3, 4]]).flat_map { |e| e + [100] })
  
    #2.26 one?
    assert_equal(['ant', 'bear', 'cat'].one? { |word| word.length == 4 }, BlockArray.new(['ant', 'bear', 'cat']).one? { |word| word.length == 4 })
    assert_equal(['ant', 'bear', 'cat'].one? { |word| word.length < 4 }, BlockArray.new(['ant', 'bear', 'cat']).one? { |word| word.length > 4 })
    assert_equal(['ant', 'bear', 'cat'].one? { |word| word.length > 4 }, BlockArray.new(['ant', 'bear', 'cat']).one? { |word| word.length < 4 })
    assert_equal([nil, true, 99].one?, BlockArray.new([nil, true, 99]).one?)
    assert_equal([nil, true, false].one?, BlockArray.new([nil, true, false]).one?)
  end 
end