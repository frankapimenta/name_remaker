require 'support/shared/names_data_context'
require 'support/shared/has_full_name'

RSpec.describe NameRemaker::NameInstance do
  include_context "names data context"

  specify { expect(described_class).not_to be_nil }
  describe "on initialization" do
    describe "ivars" do
      specify { expect(subject.instance_variables).to eq([:@first_names, :@last_names, :@name_combination]) }
      context "@name_combination" do
        specify { expect(subject.instance_variable_get(:@name_combination)).to be_instance_of(NameRemaker::NameCombination) }
        specify { expect(subject.instance_variable_get(:@name_combination).first_names).to eq first_names.split(' ') }
        specify { expect(subject.instance_variable_get(:@name_combination).last_names).to eq last_names.split(' ') }
      end
      context "@first_names" do
        specify { expect(subject.instance_variable_get(:@first_names)).to be_instance_of(Array) }
        specify { expect(subject.instance_variable_get(:@first_names)).to eq first_names.split(' ') }
      end
      context "@last_names" do
        specify { expect(subject.instance_variable_get(:@last_names)).to be_instance_of(Array) }
        specify { expect(subject.instance_variable_get(:@last_names)).to eq last_names.split(' ') }
      end
    end
    specify "sets first_names and last_names when given as args" do
      _subject = described_class.new first_names: first_names, last_names: last_names
      expect(_subject.first_names).to eq first_names.split(' ')
      expect(_subject.last_names).to eq last_names.split(' ')
    end
  end
  context "public instance methods" do
    context "#names" do
      specify { expect(subject).to respond_to(:names).with(0).arguments }
      specify { expect(subject.names).to eq names }
      specify { expect(subject.names).to be_frozen }
    end
    context "#first_names" do
      specify { expect(subject).to respond_to(:first_names).with(0).arguments }
      specify { expect(subject.first_names).to eq subject.instance_variable_get(:@first_names) }
      specify { expect(subject.first_names).to be_frozen }
    end
    context "#last_names" do
      specify { expect(subject).to respond_to(:last_names).with(0).arguments }
      specify { expect(subject.last_names).to eq subject.instance_variable_get(:@last_names) }
      specify { expect(subject.last_names).to be_frozen }
    end
    context "#first_name" do
      before { subject.__send__ :set_first_names, first_names }
      specify { expect(subject).to respond_to(:first_name).with(0).arguments }
      specify { expect(subject.first_name).to eq first_name }
      specify { expect(subject.first_name).to be_frozen }
    end
    context "#last_name" do
      before { subject.__send__ :set_last_names, last_names }
      specify { expect(subject).to respond_to(:last_name).with(0).arguments }
      specify { expect(subject.last_name).to eq last_name }
      specify { expect(subject.last_name).to be_frozen }
    end

    it_behaves_like "has #full_name"

    context "#first_and_last_name" do
      specify { expect(subject).to respond_to(:first_and_last_name).with_keywords(:separator, :reversed).with(0).arguments }
      context "not reversed" do
        before { expect(subject).not_to receive(:last_and_first_name) }
        context "without separator" do
          let(:first_and_last_name) { [first_name, last_name].join(' ') }
          specify { expect(subject.first_and_last_name).to eq first_and_last_name }
        end
        context "with separator" do
          let(:first_and_last_name) { [first_name, last_name].join('-') }
          specify { expect(subject.first_and_last_name(separator: '-')).to eq first_and_last_name }
        end
      end
      context "reversed" do
        before { expect(subject).to receive(:last_and_first_name).and_call_original }
        context "without separator and reversed" do
          let(:first_and_last_name) { [last_name, first_name].join(' ') }
          specify { expect(subject.first_and_last_name(reversed: true)).to eq first_and_last_name }
        end
        context "with separator and reversed" do
          let(:first_and_last_name) { [last_name, first_name].join('-') }
          specify { expect(subject.first_and_last_name(separator: '-', reversed: true)).to eq first_and_last_name }
        end
      end
      specify { expect(subject.first_and_last_name).to be_frozen }
    end
    context "#last_and_first_name" do
      specify { expect(subject).to respond_to(:last_and_first_name).with_keywords(:separator, :reversed).with(0).arguments }
      context "not reversed" do
        before { expect(subject).not_to receive(:first_and_last_name) }
        context "without separator" do
          let(:last_and_first_name) { [last_name, first_name].join(' ') }
          specify { expect(subject.last_and_first_name).to eq(last_and_first_name)  }
        end
        context "with separator" do
          let(:last_and_first_name) { [last_name, first_name].join('-') }
          specify { expect(subject.last_and_first_name(separator: '-')).to eq(last_and_first_name)  }
        end
      end
      context "reversed" do
        before { expect(subject).to receive(:first_and_last_name).and_call_original }
        context "without separator" do
          let(:last_and_first_name) { [first_name, last_name].join(' ') }
          specify { expect(subject.last_and_first_name(reversed: true)).to eq(last_and_first_name)  }
        end
        context "with separator" do
          let(:last_and_first_name) { [first_name, last_name].join('-') }
          specify { expect(subject.last_and_first_name(separator: '-', reversed: true)).to eq(last_and_first_name)  }
        end
      end
      specify { expect(subject.last_and_first_name).to be_frozen }
    end
    context "#middle_names" do
      specify { expect(subject).to respond_to(:middle_names).with(0).arguments }
      specify { expect(subject.middle_names).to eq(middle_names)}
      specify { expect(subject.middle_names).not_to be(middle_names)}
      specify { expect(subject.middle_names).to be_frozen }
    end
    context "#longer_than max_length:" do
      specify { expect(subject).to respond_to(:longer_than).with_keywords(:max_length).with(0).arguments }
      specify { expect(subject.longer_than(max_length: 1000)).to be_falsey }
      specify { expect(subject.longer_than(max_length: 20)).to be_truthy }
    end
    context "#combinations" do
      specify { expect(subject).to respond_to(:combinations).with(0).arguments }
      specify "forwards to @name_combination" do
        expect(subject.instance_variable_get(:@name_combination)).to receive(:all)
        subject.combinations
      end
      specify { expect(subject.combinations.map{|combination| combination.class}.uniq).to eq [NameRemaker::NameInstance] }
    end
  end
  context "private instance methods" do
    context "#set_first_names" do
      specify { expect(subject.private_methods).to include(:set_first_names) }
      specify { expect(subject.method(:set_first_names).parameters).to eq [[:req, :first_names]] }
      context "raises error if arguments are not sent as one string or array" do
        specify { expect { subject.__send__(:set_first_names, 1) }.to raise_error(ArgumentError, "first names must be given as a String or Array") }
        specify { expect { subject.__send__(:set_first_names, first_names) }.not_to raise_error }
        specify { expect { subject.__send__(:set_first_names, first_names.split(' ')) }.not_to raise_error }
      end
      specify "sets first names in ivar" do
        subject.__send__ :set_first_names, first_names
        expect(subject.instance_variable_get(:@first_names)).to eq first_names.split(' ')
        expect(subject.instance_variable_get(:@first_names)).to be_frozen
      end
    end
    context "#set_last_names" do
      specify { expect(subject.private_methods).to include(:set_last_names) }
      specify { expect(subject.method(:set_last_names).parameters).to eq [[:req, :last_names]] }
      context "raises error if arguments are not sent as one string or array" do
        specify { expect { subject.__send__(:set_last_names, 1) }.to raise_error(ArgumentError, "last names must be given as a String or Array") }
        specify { expect { subject.__send__(:set_last_names, last_names) }.not_to raise_error }
        specify { expect { subject.__send__(:set_last_names, last_names.split(' ')) }.not_to raise_error }
      end
      specify "sets last names in ivar" do
        subject.__send__ :set_last_names, last_names
        expect(subject.instance_variable_get(:@last_names)).to eq last_names.split(' ')
        expect(subject.instance_variable_get(:@last_names)).to be_frozen
      end
    end
  end
end
