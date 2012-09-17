module Avalon
  class Validator
    def initialize(target, *patterns, &block)
      @target   = target
      @patterns = patterns
      @patterns << block if block_given?
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
        @target.instance_eval(&pattern)
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
