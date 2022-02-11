# frozen_string_literal: true

require_relative "xa/version"
require_relative "xa/dsl"

module Xa
  class Error < StandardError; end
end

class Class
  include Xa::DSL
end
