module Avalon
  class Validator
    def initialize(target, *patterns)
      @target   = target
      @patterns = patterns
    end

    def validate
      raise_error if invalid?
      true
    end

    def valid?
      @patterns.any? {|pattern| check(pattern) }
    end

    def invalid?
      !valid?
    end

    private

    def check(pattern)
      if pattern.respond_to?(:call)
        pattern.call(@target)
      else
        pattern === @target
      end
    end

    def raise_error
      raise ValidationError, error_message
    end

    def error_message
      target   = @target.inspect
      patterns = @patterns.map(&:inspect).join(" or ")
      "#{target} must match #{patterns}"
    end
  end

  class ValidationError < StandardError; end
end
