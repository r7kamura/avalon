# Avalon

A validator implementation for Ruby.  
Avalon provides simple validation methods and validator class.

## Requirements
Avalon is implemented in pure ruby without any gems.  
Tested in following environments:
* MRI 1.8.7
* MRI 1.9.2
* MRI 1.9.3

## Usage

```
$ gem install avalon
```

```ruby
require "avalon"

Avalon.valid?("abc", /d/)   #=> false
Avalon.invalid?("abc", /d/) #=> true
Avalon.validate("abc", /d/) #=> "abc" must match /d/ (Avalon::ValidationError)

Avalon.valid?(:foo => "bar") { |target| target.has_key?(:foo) } #=> true
Avalon.valid?(:foo => "bar") { has_key?(:foo) }                 #=> true

class Calculator
  include Avalon

  def square(number)
    validate(number, Fixnum, /^\d+$/)
    number.to_i ** 2
  end
end

calculator = Calculator.new
calculator.square(3)       #=> 9
calculator.square("3")     #=> 9
calculator.square("three") #=> "three" must match Fixnum or /^\d+$/ (Avalon::ValidationError)

validator = Avalon::Validator.new("1", lambda {|x| x.respond_to?(:to_i) })
validator.valid?   #=> true
validator.invalid? #=> false
validator.validate #=> true
```
