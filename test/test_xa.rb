# frozen_string_literal: true

require_relative "test_helper"

class TestXa < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Xa::VERSION
  end

  class C1
    xa { subclasses require implementing(:m1, :m2) }
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

  module M1
    xa { includers require implementing(:m1) }
  end

  def test_it_does_not_raise_exception_when_required_methods_are_implemented_in_includers
    assert eval <<~RUBY, binding, __FILE__, __LINE__ + 1
      class D1
        include M1

        def m1; end
      end
    RUBY
  end

  module M2
    def m1; end
  end

  def test_it_does_not_raise_exception_when_required_methods_are_implemented_in_includers_via_another_module
    assert eval <<~RUBY, binding, __FILE__, __LINE__ + 1
      class D2
        include M1
        include M2
      end
    RUBY
  end

  def test_it_raises_exception_when_required_methods_are_not_implemented_in_includers
    assert_raises(Xa::Error) do
      eval <<~RUBY, binding, __FILE__, __LINE__ + 1
        class D3
          include M1
        end
      RUBY
    end
  end

  def test_it_does_not_raise_exception_when_required_methods_are_implemented_in_including_modules
    assert eval <<~RUBY, binding, __FILE__, __LINE__ + 1
      module M3
        include M1

        def m1; end
      end
    RUBY
  end

  def test_it_does_not_raise_exception_when_required_methods_are_implemented_in_including_modules_via_another_module
    assert eval <<~RUBY, binding, __FILE__, __LINE__ + 1
      module M4
        include M1
        include M2
      end
    RUBY
  end

  def test_it_raises_exception_when_required_methods_are_not_implemented_in_including_modules
    assert_raises(Xa::Error) do
      eval <<~RUBY, binding, __FILE__, __LINE__ + 1
        module M5
          include M1
        end
      RUBY
    end
  end
end
