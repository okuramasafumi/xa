# frozen_string_literal: true

require "test_helper"

class TestXa < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Xa::VERSION
  end

  class C1
    subclasses need implementing(:m1, :m2)
  end

  def test_it_does_not_raise_exception_when_required_methods_are_implemented
    assert eval <<~RUBY, binding, __FILE__, __LINE__ + 1
      class C2 < C1
        def m1; end
        def m2; end
      end
    RUBY
  end

  module M
    def m1; end

    def m2; end
  end

  def test_it_does_not_raise_exception_when_required_methods_are_implemented_via_module
    assert eval <<~RUBY, binding, __FILE__, __LINE__ + 1
      class C3 < C1
        include M
      end
    RUBY
  end

  def test_it_raises_exception_when_required_methods_are_not_implemented
    assert_raises(Xa::Error) do
      eval <<~RUBY, binding, __FILE__, __LINE__ + 1
        class C4 < C1
        end
      RUBY
    end
  end
end
