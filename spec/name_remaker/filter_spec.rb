require 'spec_helper'

RSpec.describe NameRemaker::Filter do
  subject { described_class.new(collection) }
  let(:collection) { double(:collection) }
  specify { expect(described_class).not_to be_nil }
  context "ivars" do
    context "@collection" do
      specify { expect(subject.instance_variables).to include(:@collection) }
      specify { expect(subject.instance_variable_get(:@collection)).to eq(collection) }
    end
    context "@condition" do
      context "without condition" do
        specify { expect(subject.instance_variables).to include(:@condition) }
        specify { expect(subject.instance_variable_get(:@condition)).to eq(nil) }
      end
      context "with condition" do
        subject { described_class.new(collection, &condition) }
        let(:condition) { ->(item) { item > 10 } }
        specify { expect(subject.instance_variables).to include(:@condition) }
        specify { expect(subject.instance_variable_get(:@condition)).to eq(condition) }
      end
    end
  end
  context "instance methods" do
    context "#collection" do
      specify { expect(subject).to respond_to(:collection).with(0).arguments }
      specify { expect(subject.collection).to eq(collection) }
    end
    context "#condition" do
      subject { described_class.new(collection, &condition) }
      let(:condition) { ->(item) { item > 10 } }
      specify { expect(subject).to respond_to(:condition).with(0).arguments }
      specify { expect(subject.condition).to eq(condition) }
    end
    context "#filtered" do
      context "without condition given on init" do
        specify { expect(subject).to respond_to(:filtered).with(0).arguments }
        specify { expect {subject.filtered}.to raise_error NotImplementedError }
      end
      context "with condition given on init" do
        subject { described_class.new(collection, &condition) }
        let(:collection) { ["Frank Alessander Pimenta", "Frank Pimenta"]}
        let(:condition) { ->(item) { item.length < 15 } }
        specify { expect(subject).to respond_to(:filtered).with(0).arguments }
        specify { expect {subject.filtered}.not_to raise_error }
        specify "executes condition" do
          expect(collection).to receive(:select)
          subject.filtered
        end
        specify { expect(subject.filtered).to eq(["Frank Pimenta"]) }
      end
    end
    context "#unfiltered" do
      context "without condition given on init" do
        specify { expect(subject).to respond_to(:unfiltered).with(0).arguments }
        specify { expect {subject.unfiltered}.to raise_error NotImplementedError }
      end
      context "with condition given on init" do
        subject { described_class.new(collection, &condition) }
        let(:collection) { ["Frank Alessander Pimenta", "Frank Pimenta"]}
        let(:condition) { ->(item) { item.length < 15 } }
        specify { expect(subject).to respond_to(:filtered).with(0).arguments }
        specify { expect {subject.unfiltered}.not_to raise_error }
        specify "executes condition" do
          expect(collection).to receive(:select)
          subject.unfiltered
        end
        specify { expect(subject.unfiltered).to eq(["Frank Alessander Pimenta"]) }
      end
    end
  end
end
