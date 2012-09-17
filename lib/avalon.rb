require "avalon/version"
require "avalon/validator"

module Avalon
  extend self

  def validate(*args, &block)
    Validator.new(*args, &block).validate
  end

  def valid?(*args, &block)
    Validator.new(*args, &block).valid?
  end

  def invalid?(*args, &block)
    Validator.new(*args, &block).invalid?
  end
end
