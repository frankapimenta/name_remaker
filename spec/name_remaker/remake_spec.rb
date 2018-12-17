require 'support/shared/names_data_context'
require 'support/shared/has_full_name'

RSpec.describe NameRemaker::Remake do
  include_context 'names data context'

  specify { expect(described_class).not_to eq(nil) }

  context "included modules" do
    specify { expect(described_class.included_modules).to include(Enumerable) }
  end
  describe "on initialization" do
    describe "ivars" do
      context "name_instance" do
        specify { expect(subject.instance_variables).to include(:@name_instance) }
        specify { expect(subject.instance_variable_get(:@name_instance)).to be_instance_of NameRemaker::NameInstance }
        specify { expect(subject.instance_variable_get(:@name_instance).first_names).to eq first_names.split(' ') }
        specify { expect(subject.instance_variable_get(:@name_instance).last_names).to eq last_names.split(' ') }
      end
    end
  end
  context "instance methods" do
    context "#name_instance" do
      specify { expect(subject).to respond_to(:name_instance).with(0).arguments }
      specify { expect(subject.name_instance).to be_instance_of(NameRemaker::NameInstance) }
    end

    it_behaves_like "has #full_name"

    context "#list" do
      specify { expect(subject).to respond_to(:list).with(0).arguments }
      specify { expect(subject.list).to be_instance_of(NameRemaker::NameList) }
    end
    context "#all" do
      specify { expect(subject).to respond_to(:all).with(0).arguments }
      specify "redirects to #list" do
        expect(subject).to receive_message_chain(:list, :all)
        subject.all
      end
      specify { expect(subject.all).to be_instance_of(Array) }
      specify { expect(subject.all.size).to eq(subject.list.all.size)}
    end
    context "#each" do
      specify { expect(subject).to respond_to(:each).with(0).arguments }
      specify "redirects to all" do
        expect(subject).to receive_message_chain(:all, :each)
        subject.each
      end
    end
    context "#inspect" do
      specify { expect(subject).to respond_to(:inspect).with(0).arguments }
      specify "redirects to all" do
        expect(subject).to receive(:all)
        subject.inspect
      end
    end
    context "#print" do
      let(:combination) { double(:combination) }
      specify { expect(subject).to respond_to(:print).with_keywords(:separator, :reversed).with(0).arguments }
      specify "receives #each" do
        expect(subject).to receive(:each)
        subject.print
      end
      specify "#each yield combination to receive #full_name with separator and reversed keywords" do
        expect(subject).to receive(:each).and_yield combination
        expect(combination).to receive(:full_name).with(separator: ' ', reversed: false)
        subject.print
      end
      specify { expect(subject.print).to be_instance_of(Enumerator) }
    end
    context "#max_length_of" do
      specify { expect(subject).to respond_to(:max_length_of).with(1).argument }
      specify "redirects to #list" do
        expect(subject).to receive_message_chain(:list, :max_length_of)
        subject.max_length_of 35
      end
      specify { expect(subject.max_length_of(35).any?).to be_truthy }
    end
    context "#full_name_longer_than" do
      specify { expect(subject).to respond_to(:full_name_longer_than).with(1).argument }
      specify "receives #name_instance" do
        expect(subject).to receive(:name_instance).and_call_original
        subject.full_name_longer_than(35)
      end
      specify { expect(subject.full_name_longer_than(25)).to be_truthy }
      specify { expect(subject.full_name_longer_than(60)).to be_falsey }
    end
  end
end

