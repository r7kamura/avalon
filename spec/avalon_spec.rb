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

  context "when included" do
    let(:klass) do
      Class.new do
        include Avalon

        def abc
          "abc"
        end
      end
    end

    context "when not given target but given block" do
      it "should take self as target of validation" do
        expect do
          klass.new.validate { abc =~ /def/ }
        end.to raise_error(Avalon::ValidationError)
      end
    end
  end
end
