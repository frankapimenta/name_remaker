require 'support/shared/names_data_context'

RSpec.describe NameRemaker::NameList do
  include_context "names data context"

  subject { described_class.new name_instance }
  let(:name_instance) { NameRemaker::NameInstance.new first_names: first_names, last_names: last_names }

  specify { expect(described_class).not_to be_nil }
  describe "included modules" do
    specify { expect(described_class.included_modules).to include(Enumerable) }
  end
  describe "on initialization" do
    describe "ivars" do
      context "name_instance" do
        specify { expect(subject.instance_variables).to eq([:@name_instance]) }
        specify { expect(subject.instance_variable_get(:@name_instance)).to be_instance_of NameRemaker::NameInstance }
        specify { expect(subject.instance_variable_get(:@name_instance).first_names).to eq first_names.split(' ') }
        specify { expect(subject.instance_variable_get(:@name_instance).last_names).to eq last_names.split(' ') }
      end
    end
  end
  context "instance methods" do
     context "#all" do
      specify { expect(subject).to respond_to(:all).with(0).arguments }
      specify "forwards to @name_instance" do
        expect(subject.instance_variable_get(:@name_instance)).to receive(:combinations)
        subject.all
      end
      context "has suggestions" do
        specify { expect(subject.all.any?).to be_truthy }
      end
    end
    context "#each" do
      specify { expect(subject).to respond_to(:each).with(0).arguments }
      specify "redirects to all" do
        expect(subject).to receive_message_chain(:all, :each)
        subject.each
      end
    end
    context "#max_length_of" do
      let(:max_length) { 35 }
      specify { expect(subject).to respond_to(:max_length_of).with(1).arguments }
      specify "calls #all" do
        expect(subject).to receive(:all).and_call_original
        subject.max_length_of 35
      end
      context "for slightly_too_long name" do
        let(:suggestion1)   { "Tom Mark Antonio Smith Grant Cruise" }
        let(:suggestion2)   { "Tom Antonio Smith Grant Cruise" }
        let(:suggestion3)   { "Tom Mark Antonio Smith Cruise" }
        let(:suggestion4)   { "Tom Mark Antonio Grant Cruise" }
        let(:suggestion5)   { "Tom Mark Antonio Smith Grant" }
        let(:suggestion6)   { "Tom Mark Smith Grant Cruise" }
        let(:suggestion7)   { "Tom Antonio Grant Cruise" }
        let(:suggestion8)   { "Tom Antonio Smith Cruise" }
        let(:suggestion9)   { "Tom Antonio Smith Grant" }
        let(:suggestion10)  { "Tom Mark Antonio Cruise" }
        let(:suggestion11)  { "Tom Mark Antonio Grant" }
        let(:suggestion12)  { "Tom Mark Antonio Smith" }
        let(:suggestion13)  { "Tom Smith Grant Cruise" }
        let(:suggestion14)  { "Tom Mark Smith Cruise" }
        let(:suggestion15)  { "Tom Mark Grant Cruise" }
        let(:suggestion16)  { "Tom Mark Smith Grant" }
        let(:suggestion17)  { "Tom Antonio Cruise" }
        let(:suggestion18)  { "Tom Antonio Grant" }
        let(:suggestion19)  { "Tom Antonio Smith" }
        let(:suggestion20)  { "Tom Smith Cruise" }
        let(:suggestion21)  { "Tom Grant Cruise" }
        let(:suggestion22)  { "Tom Mark Cruise" }
        let(:suggestion23)  { "Tom Smith Grant" }
        let(:suggestion24)  { "Tom Mark Grant" }
        let(:suggestion25)  { "Tom Mark Smith" }
        let(:suggestion26)  { "Tom Cruise" }
        let(:suggestion27)  { "Tom Smith" }
        let(:suggestion28)  { "Tom Grant" }

        specify "has in order combinations" do
          suggestions = (1..28).to_a.map do |index|
            __send__("suggestion#{index}")
          end.sort
          results = subject.max_length_of(max_length).map(&:full_name).sort
          expect(results).to eq suggestions
        end
      end
      context "for short length" do
        let(:max_length) { 10 }
        specify { expect(subject.max_length_of(max_length).size).to eq(3) }
        specify { expect(subject.max_length_of(max_length).first).to be_instance_of(NameRemaker::NameInstance) }
        ["Tom Cruise", "Tom Smith", "Tom Grant"].each do |shortened_name|
          specify { expect(subject.max_length_of(max_length).map(&:full_name)).to include shortened_name }
        end
      end
    end
  end
end
