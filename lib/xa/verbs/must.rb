# frozen_string_literal: true

module Xa
  # The argument class for `subclasses` DSL
  class Must
    def initialize(verb)
      @verb = verb
    end

    # Declare subclasses require certain conditions
    def trace!(current_class)
      TracePoint.trace :end do |tp|
        klass = tp.self
        next unless target?(klass, current_class)

        @verb.check_implementation(klass)
      end
    end

    private

    def target?(klass, current_class)
      klass.name != current_class.name && klass.ancestors.include?(current_class)
    end
  end
end
