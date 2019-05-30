require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutKeywordArguments < Neo::Koan

  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  def test_keyword_arguments
    assert_equal Array, method_with_keyword_arguments.class
    assert_equal [1, 'two'], method_with_keyword_arguments
    assert_equal ['one', 'two'], method_with_keyword_arguments(one: 'one')
    assert_equal [1, 2], method_with_keyword_arguments(two: 2)
  end

  def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3)
    [one, two, three]
  end

  def test_keyword_arguments_with_wrong_number_of_arguments
    exception = assert_raise (ArgumentError) do
      method_with_keyword_arguments_with_mandatory_argument
    end
    assert_match(/wrong number of arguments/, exception.message)
  end

  # THINK ABOUT IT:
  #
  # Keyword arguments always have a default value, making them optional to the caller

  # MY TESTS!!!

  def method_with_required_keyword_arguments(x:,y:)
    [x, y]
  end

  def test_required_keyword_arguments
    exception = assert_raise(ArgumentError) do
      method_with_required_keyword_arguments(1, 2)
    end
    assert_match(/keywords/, exception.message)
  end

  def method_with_optional_keywords(x:, y:2 , z:)
    [x, y, z]
  end

  def test_optional_keyword_arguments
    assert_equal [1, 2, 0], method_with_optional_keywords(x: 1, z: 0)
    assert_equal [1, 2, 3], method_with_optional_keywords(x: 1, y: 2, z: 3)
  end

  def method_with_variadic_keyword_arguments(**kwargs)
    kwargs
  end

  def test_variadic_keyword_arguments
    assert_equal({:x => 1, :y => 2}, method_with_variadic_keyword_arguments(x: 1, y:2))
  end
end
