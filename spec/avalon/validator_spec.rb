require "spec_helper"

describe Avalon::Validator do
  describe "#valid?" do
    context "given String pattern" do
      context "when matched" do
        it do
          Avalon::Validator.new("target", "target").should be_valid
        end
      end

      context "not matched" do
        it do
          Avalon::Validator.new("target", "not matched").should_not be_valid
        end
      end
    end

    context "given Regexp pattern" do
      context "when matched" do
        it do
          Avalon::Validator.new("target", /target/).should be_valid
        end
      end

      context "when not matched" do
        it do
          Avalon::Validator.new("target", /not matched/).should_not be_valid
        end
      end
    end

    context "given Class pattern" do
      context "when matched" do
        it do
          Avalon::Validator.new("target", String).should be_valid
        end
      end

      context "when not matched" do
        it do
          Avalon::Validator.new("target", Fixnum).should_not be_valid
        end
      end
    end

    context "given Proc pattern" do
      it "should evaluated in target's context" do
        Avalon::Validator.new("target") { match(/target/) }.should be_valid
      end

      context "when matched" do
        it do
          Avalon::Validator.new("target", proc {|x| x =~ /target/ }).should be_valid
        end
      end

      context "when not matched" do
        it do
          Avalon::Validator.new("target", proc {|x| x =~ /not match/ }).should_not be_valid
        end
      end
    end

    context "given Block pattern" do
      context "when matched" do
        it do
          Avalon::Validator.new("target") {|x| x =~ /target/ }.should be_valid
        end
      end

      context "when not matched" do
        it do
          Avalon::Validator.new("target") {|x| x =~ /not match/ }.should_not be_valid
        end
      end

      it "should evaluated in target's context" do
        Avalon::Validator.new("target") { match(/target/) }.should be_valid
      end
    end

    context "given multiple OR-patterns" do
      context "when matched" do
        it do
          Avalon::Validator.new("target", Fixnum, "target").should be_valid
        end
      end

      context "when not matched" do
        it do
          Avalon::Validator.new("target", Fixnum, /not matched/).should_not be_valid
        end
      end
    end
  end

  describe "#invalid?" do
    it "should behave like a counter method of #valid?" do
      Avalon::Validator.new("target", "not matched").should be_invalid
    end
  end

  describe "#validate" do
    context "in valid case" do
      it do
        expect do
          Avalon::Validator.new("target", "target").validate
        end.to_not raise_error(Avalon::ValidationError)
      end
    end

    context "in invalid case" do
      it "should raise Avalon::ValidationError with message that includes target and patterns" do
        expect do
          Avalon::Validator.new("target", Fixnum, /not matched/).validate
        end.to raise_error(Avalon::ValidationError, '"target" must match Fixnum or /not matched/')
      end
    end
  end
end
