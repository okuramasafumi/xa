# frozen_string_literal: true

module Xa
  # Representing missing implementation in given class (klass)
  # This class might need subclasses, but for now I keep it
  class MissingImplementation
    def initialize(kind:, klass:, name:, missed_call: nil)
      @kind = kind
      @klass = klass
      @name = name
      @missed_call = missed_call
    end

    def message
      case @kind
      when :missing
        "Class #{@klass} has a missing method `#{@name}`"
      when :missing_call
        "Class #{@klass} has a missing method `#{@missed_call}` in `#{@name}`"
      end
    end
  end
end
