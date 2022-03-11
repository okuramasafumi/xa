# frozen_string_literal: true

require "test_helper"

class TestInitialize < Minitest::Test
  def test_it_does_not_raise_exception_when_required_methods_are_implemented
    assert load("support/subclass_with_initialize_calling_super.rb", true)
  end

  def test_it_raises_exception_when_required_methods_are_not_implemented
    error = assert_raises(Xa::Error) do
      load("support/subclass_without_initialize_calling_super.rb")
    end
    assert_equal "Class C2 has a missing method `super` in `initialize`", error.message
  end
end
