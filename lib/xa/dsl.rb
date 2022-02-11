# frozen_string_literal: true

require_relative "subclass_proxy"

module Xa
  # A module containing DSL
  module DSL
    def subclasses
      SubclassProxy.new(self)
    end
  end
end
