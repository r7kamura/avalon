require "avalon/version"
require "avalon/validator"

module Avalon
  extend self

  def validate(*args)
    Validator.new(*args).validate
  end

  def valid?(*args)
    Validator.new(*args).valid?
  end

  def invalid?(*args)
    Validator.new(*args).invalid?
  end
end
