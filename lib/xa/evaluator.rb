# frozen_string_literal: true

require_relative "implementing"
require_relative "require"

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

    def require(implementing)
      Require.new(implementing)
    end

    def implementing(*method_names)
      Implementing.new(method_names)
    end
  end
end
