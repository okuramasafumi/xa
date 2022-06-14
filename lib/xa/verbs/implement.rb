# frozen_string_literal: true

require_relative "../missing_implementation"

using Module.new { # rubocop:disable Lint/AmbiguousBlockAssociation
  refine RubyVM::AbstractSyntaxTree::Node do
    def traverse(*types, &block)
      children.each do |node|
        yield(node) if node.respond_to?(:type) && types.include?(node.type)
        node.traverse(*types, &block) if node.respond_to?(:traverse)
      end
    end
  end
}

module Xa
  # Containing implementation requirements
  class Implement
    def initialize(method_names, **options)
      @method_names = method_names
      @calling = options[:calling]
    end

    def check_implementation(klass)
      missings = @method_names.map do |name|
        if !klass.instance_methods.include?(name) && !klass.private_instance_methods.include?(name)
          MissingImplementation.new(klass: klass, kind: :missing, name: name)
        elsif missing_method_call(klass, name)
          MissingImplementation.new(klass: klass, kind: :missing_call, name: name, missed_call: @calling)
        end
      end.compact

      raise Xa::Error, missings.map(&:message).join unless missings.empty?
    end

    private

    def missing_method_call(klass, name)
      return false if @calling.nil?

      method_object = klass.instance_method(name) || klass.method(name) || klass.private_instance_method(name) || private_method(name) # rubocop:disable Layout/LineLength
      return false unless method_object

      ast = RubyVM::AbstractSyntaxTree.of(method_object)
      return true unless ast

      traverse(ast, name)
    end

    def traverse(ast, name)
      ast.traverse(:CALL, :VCALL, :ZSUPER, :SUPER) do |node|
        case node.type
        when :CALL
          return false if node.children[1] == name
        when :VCALL
          return false if node.children[0] == name
        when :ZSUPER, :SUPER
          return false
        end
      end
    end
  end
end
