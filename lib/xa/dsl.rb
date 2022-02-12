# frozen_string_literal: true

require_relative "implementing"
require_relative "need"

module Xa
  # A module containing DSL
  module DSL
    def subclasses(need)
      need.trace!(self)
    end

    def need(implementing)
      Need.new(implementing)
    end

    def implementing(*method_names)
      Implementing.new(method_names)
    end
  end
end
