require 'spec_helper'

RSpec.describe NameRemaker::MaxLengthFilter do
  subject { described_class.new(collection, max_length) }
  let(:first_item)  { NameRemaker::remake(first_names: "Frank", last_names: "Pimenta") }
  let(:second_item) { NameRemaker::remake(first_names: "Frank Alessander", last_names: "Pimenta") }
  let(:collection)  { [first_item, second_item] }
  let(:max_length)  { 15 }
  specify { expect(described_class).not_to be_nil }
  specify { expect(described_class.superclass).to eq(NameRemaker::Filter) }

  context "initialization" do
    context "raise if block given" do
      specify { expect { described_class.new(collection, max_length) {|item| item.length < 10 } }.to raise_error ArgumentError, "block is not accepted" }
    end
  end
  context "ivars" do
    context "@max_length" do
      specify { expect(subject.instance_variables).to include(:@max_length) }
      specify { expect(subject.instance_variable_get(:@max_length)).to eq(max_length) }
    end
  end
  context "instance_methods" do
    context "max_length" do
      specify { expect(subject).to respond_to(:max_length).with(0).arguments }
      specify { expect(subject.max_length).to eq(max_length) }
    end
    context "collection" do
      specify { expect(subject).to respond_to(:collection).with(0).arguments }
      specify { expect(subject.collection).to eq(collection) }
    end
    context "condition" do
      specify { expect(subject).to respond_to(:condition).with(0).arguments }
      specify { expect(subject.condition).to be_instance_of(Proc) }
    end
    context "filtered" do
      specify { expect(subject).to respond_to(:filtered).with(0).arguments }
      specify "is implemented" do
        expect { subject.filtered }.not_to raise_error
      end
      specify "returns filtered collection results" do
        expect(subject.filtered.first.full_name).to eq("Frank Pimenta")
      end
    end
    context "unfiltered" do
      specify { expect(subject).to respond_to(:unfiltered).with(0).arguments }
      specify "is implemented" do
        expect { subject.unfiltered }.not_to raise_error
      end
      specify "returns unfiltered collection results" do
        expect(subject.unfiltered.map(&:full_name)).to eq(["Frank Alessander Pimenta"])
      end
    end
  end
end
