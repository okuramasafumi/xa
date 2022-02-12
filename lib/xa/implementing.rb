# frozen_string_literal: true

module Xa
  # Containing implementation requirements
  class Implementing
    attr_reader :method_names

    def initialize(method_names)
      @method_names = method_names
    end
  end
end
