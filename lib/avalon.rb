require "avalon/version"
require "avalon/validator"

module Avalon
  extend self

  def validate(*args, &block)
    delegate(:validate, *args, &block)
  end

  def valid?(*args, &block)
    delegate(:valid?, *args, &block)
  end

  def invalid?(*args, &block)
    delegate(:invalid?, *args, &block)
  end

  private

  # In the usage of include, use self as target if target is abbreviated
  def delegate(method_name, *args, &block)
    args.unshift(self) if args.empty? && block_given?
    Validator.new(*args, &block).send(method_name)
  end
end
