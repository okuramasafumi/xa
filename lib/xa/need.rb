# frozen_string_literal: true

module Xa
  # The argument class for `subclasses` DSL
  class Need
    attr_reader :method_names

    def initialize(implementing)
      @method_names = implementing.method_names
    end

    # Declare subclasses require certain conditions
    def trace!(current_class)
      TracePoint.trace :end do |tp|
        klass = tp.self
        next unless target?(klass, current_class)

        unless method_names.all? { |name| klass.instance_methods.include?(name) }
          raise Xa::Error, "#{klass.name} is required to implement #{method_names.join(", ")}"
        end
      end
    end

    private

    def target?(klass, current_class)
      klass.name != current_class.name && klass.ancestors.include?(current_class)
    end
  end
end
