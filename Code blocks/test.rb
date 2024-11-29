require_relative "BlockArray"
require "test/unit"
 
class TestBlockArray < Test::Unit::TestCase
  def test_all
    assert_equal(['ant', 'bear', 'cat'].all? { |word| word.length >= 3 }, BlockArray.new(['ant', 'bear', 'cat']).all? { |word| word.length >= 3 })
    assert_equal(['ant', 'bear', 'cat'].all? { |word| word.length >= 4 }, BlockArray.new(['ant', 'bear', 'cat']).all? { |word| word.length >= 4 })
    assert_equal([nil, true, 99].all?, BlockArray.new([nil, true, 99]).all?)
    assert_equal([].all?, BlockArray.new([]).all?)
  end

  def test_flat_map
    assert_equal([1, 2, 3, 4].flat_map { |e| [e, -e] }, BlockArray.new([1, 2, 3, 4]).flat_map { |e| [e, -e] })
    assert_equal([[1, 2], [3, 4]].flat_map { |e| e + [100] }, BlockArray.new([[1, 2], [3, 4]]).flat_map { |e| e + [100] })
  end
  
  def test_one 
    assert_equal(['ant', 'bear', 'cat'].one? { |word| word.length == 4 }, BlockArray.new(['ant', 'bear', 'cat']).one? { |word| word.length == 4 })
    assert_equal(['ant', 'bear', 'cat'].one? { |word| word.length < 4 }, BlockArray.new(['ant', 'bear', 'cat']).one? { |word| word.length > 4 })
    assert_equal(['ant', 'bear', 'cat'].one? { |word| word.length > 4 }, BlockArray.new(['ant', 'bear', 'cat']).one? { |word| word.length < 4 })
    assert_equal([nil, true, 99].one?, BlockArray.new([nil, true, 99]).one?)
    assert_equal([nil, true, false].one?, BlockArray.new([nil, true, false]).one?)
  end

  def test_inject
    assert_equal([5,6,7,8,9,10].inject { |sum, n| sum + n }, BlockArray.new([5,6,7,8,9,10]).inject { |sum, n| sum + n })
    assert_equal([5,6,7,8,9,10].inject(1) { |product, n| product * n }, BlockArray.new([5,6,7,8,9,10]).inject(1) { |product, n| product * n })
    assert_equal(['cat', 'sheep', 'bear'].inject { |memo, word| memo.length > word.length ? memo : word }, BlockArray.new(['cat', 'sheep', 'bear']).inject { |memo, word| memo.length > word.length ? memo : word })
  end

  def test_min_by
    assert_equal(['albatross ', 'dog', 'horse'].min_by { |x| x.length }, BlockArray.new(['albatross ', 'dog', 'horse']).min_by { |x| x.length })
    assert_equal(['albatross ', 'dog', 'horse'].min_by(2) { |x| x.length }, BlockArray.new(['albatross ', 'dog', 'horse']).min_by(2) { |x| x.length })
  end

  def test_find
    assert_equal([1..10].find { |i| i % 5 == 0 and i % 7 == 0 }, BlockArray.new([1..10]).find { |i| i % 5 == 0 and i % 7 == 0 })
    assert_equal([1..100].find { |i| i % 5 == 0 and i % 7 == 0 }, BlockArray.new([1..100]).find { |i| i % 5 == 0 and i % 7 == 0 })
    assert_equal([1..10].find(lambda {"Нет совпадений"}) { |i| i % 5 == 0 and i % 7 == 0 },  BlockArray.new([1..10]).find(lambda {"Нет совпадений"}) { |i| i % 5 == 0 and i % 7 == 0 })
    assert_equal([1..10].find(Proc.new {"Нет совпадений"}) { |i| i % 5 == 0 and i % 7 == 0 },  BlockArray.new([1..10]).find(Proc.new {"Нет совпадений"}) { |i| i % 5 == 0 and i % 7 == 0 })
  end 
end