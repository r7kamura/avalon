require "spec_helper"

describe Avalon do
  describe ".#validate" do
    it "should call Validator#validate" do
      expect do
        Avalon.validate("target", "not match")
      end.to raise_error(Avalon::ValidationError)
    end
  end

  describe ".#valid?" do
    it "should call Validator#valid?" do
      Avalon.valid?("target", "target").should be_true
    end
  end

  describe ".#valid?" do
    it "should call Validator#invalid?" do
      Avalon.invalid?("target", "not match").should be_true
    end
  end
end
