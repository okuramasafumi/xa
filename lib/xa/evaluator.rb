# frozen_string_literal: true

require_relative "verbs/implement"
require_relative "verbs/must"

module Xa
  # Receiver of `instance_eval`
  class Evaluator
    def initialize(current_class)
      @current_class = current_class
    end

    def subclasses(require)
      require.trace!(@current_class)
    end
    alias includers subclasses

    def must(verb)
      Must.new(verb)
    end

    def implement(*method_names, **options)
      Implement.new(method_names, **options)
    end
  end
end
