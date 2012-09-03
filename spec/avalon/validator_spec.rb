require "spec_helper"

describe Avalon::Validator do
  describe "#valid?" do

    where(:input, :pattern, :valid) do
      [
        ["target", "target",      true  ],
        ["target", "not matched", false ],

        ["target", /target/,      true  ],
        ["target", /not matched/, false ],

        ["target", String,        true  ],
        ["target", Fixnum,        false ],

        ["target",  proc {|x| x =~ /target/ },    true],
        ["target",  proc {|x| x =~ /not match/ }, false]
      ]
    end

    with_them do
      specify do
        expect(Avalon::Validator.new(input, pattern).valid?).to eq(valid)
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
