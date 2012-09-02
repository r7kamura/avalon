require "spec_helper"

describe Avalon do
  describe ".#validate" do
    it "should call Validator#validate" do
      Avalon::Validator.any_instance.should_receive(:validate)
      Avalon.validate("target", "pattern")
    end
  end

  describe ".#valid?" do
    it "should call Validator#valid?" do
      Avalon::Validator.any_instance.should_receive(:valid?)
      Avalon.valid?("target", "pattern")
    end
  end

  describe ".#valid?" do
    it "should call Validator#invalid?" do
      Avalon::Validator.any_instance.should_receive(:invalid?)
      Avalon.invalid?("target", "pattern")
    end
  end
end
