# frozen_string_literal: true

require_relative "xa/version"
require_relative "xa/evaluator"

module Xa
  class Error < StandardError; end
end

# Open class for Class
class Class
  def xa(&block)
    Xa::Evaluator.new(self).instance_eval(&block)
  end
end
