# frozen_string_literal: true

module Xa
  # A proxy class to store data from DSL
  class SubclassProxy
    def initialize(klass)
      @klass = klass
    end

    # Declare subclasses require certain conditions
    def require(conditions)
      TracePoint.trace :end do |tp|
        klass = tp.self
        next unless target?(klass)

        method_names = Array(conditions[:method])
        unless method_names.all? { |name| klass.instance_methods.include?(name) }
          raise Xa::Error, "#{klass.name} is required to implement #{method_names.join(", ")}"
        end
      end
    end

    private

    def target?(klass)
      klass.name != @klass.name && klass.ancestors.include?(@klass)
    end
  end
end
