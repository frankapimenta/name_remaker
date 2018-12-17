require 'support/shared/names_data_context'
require 'support/shared/has_full_name'

module NameRemaker
  RSpec.describe NameCombination do
    include_context "names data context"
    subject { described_class.new(name_instance) }
    let(:name_instance) { NameRemaker::NameInstance.new(first_names: first_names, last_names: last_names) }
    specify { expect(described_class).to be_a Class }
    context "on initialization" do
      describe "ivars" do
        context "@name_instance" do
          specify { expect(subject.instance_variables).to eq([:@name_instance]) }
          specify { expect(subject.instance_variable_get(:@name_instance)).to be_instance_of(NameRemaker::NameInstance) }
          specify { expect(subject.instance_variable_get(:@name_instance).first_names).to eq first_names.split(' ') }
          specify { expect(subject.instance_variable_get(:@name_instance).last_names).to eq last_names.split(' ') }
        end
      end
    end
    context "public instance methods" do
      context "#first_names" do
        specify { expect(subject).to respond_to(:first_names).with(0).arguments }
        specify "delegates to @name_instance" do
          expect(subject.instance_variable_get(:@name_instance)).to receive(:first_names)
          subject.first_names
        end
        specify { expect(subject.first_names).to eq first_names.split(' ') }
        specify { expect(subject.first_names).to be_instance_of(Array) }
      end
      context "#last_names" do
        specify { expect(subject).to respond_to(:last_names).with(0).arguments }
        specify "delegates to @name_instance" do
          expect(subject.instance_variable_get(:@name_instance)).to receive(:last_names)
          subject.last_names
        end
        specify { expect(subject.last_names).to eq last_names.split(' ') }
        specify { expect(subject.last_names).to be_instance_of(Array) }
      end
      context "#first_name" do
        specify { expect(subject).to respond_to(:first_name).with(0).arguments }
        specify "delegates to @name_instance" do
          expect(subject.instance_variable_get(:@name_instance)).to receive(:first_name).and_call_original
          subject.first_name
        end
        specify { expect(subject.first_name).to eq first_name }
      end
      context "#middle_names" do
        specify { expect(subject).to respond_to(:middle_names).with(0).arguments }
        specify "delegates to @name_instance" do
          expect(subject.instance_variable_get(:@name_instance)).to receive(:middle_names).and_call_original
          subject.middle_names
        end
        specify { expect(subject.middle_names).to eq(middle_names) }
      end
      context "#all" do
        # specify all full name combinations as NameCombination instances
        specify { expect(subject).to respond_to(:all).with(0).arguments }
        specify do
          expect(subject).to receive(:full_name_combinations)
          subject.all
        end
        context "all combinations " do
          let(:first_names)  { "Frank Alessander Amorim" }
          let(:last_names)   { "Oliveira Lopes Santos Pimenta" }
          let(:suggestion1)  { "Frank Alessander Amorim Oliveira Lopes Santos Pimenta" }
          let(:suggestion2)  { "Frank Alessander Amorim Oliveira Santos Pimenta" }
          let(:suggestion3)  { "Frank Alessander Amorim Oliveira Lopes Pimenta" }
          let(:suggestion4)  { "Frank Alessander Amorim Lopes Santos Pimenta" }
          let(:suggestion5)  { "Frank Alessander Amorim Oliveira Pimenta" }
          let(:suggestion6)  { "Frank Alessander Amorim Lopes Pimenta" }
          let(:suggestion7)  { "Frank Alessander Amorim Santos Pimenta" }

          let(:suggestion8)  { "Frank Alessander Oliveira Lopes Santos Pimenta" }
          let(:suggestion9)  { "Frank Alessander Oliveira Santos Pimenta" }
          let(:suggestion10) { "Frank Alessander Oliveira Lopes Pimenta" }
          let(:suggestion11) { "Frank Alessander Lopes Santos Pimenta" }
          let(:suggestion12) { "Frank Alessander Oliveira Pimenta" }
          let(:suggestion13) { "Frank Alessander Lopes Pimenta" }
          let(:suggestion14) { "Frank Alessander Santos Pimenta" }

          let(:suggestion15) { "Frank Amorim Oliveira Lopes Santos Pimenta" }
          let(:suggestion16) { "Frank Amorim Oliveira Santos Pimenta" }
          let(:suggestion17) { "Frank Amorim Oliveira Lopes Pimenta" }
          let(:suggestion18) { "Frank Amorim Lopes Santos Pimenta" }
          let(:suggestion19) { "Frank Amorim Oliveira Pimenta" }
          let(:suggestion20) { "Frank Amorim Lopes Pimenta" }
          let(:suggestion21) { "Frank Amorim Santos Pimenta" }

          let(:suggestion22) { "Frank Oliveira Lopes Santos Pimenta" }
          let(:suggestion23) { "Frank Oliveira Santos Pimenta" }
          let(:suggestion24) { "Frank Oliveira Lopes Pimenta" }
          let(:suggestion25) { "Frank Lopes Santos Pimenta" }
          let(:suggestion26) { "Frank Oliveira Pimenta" }
          let(:suggestion27) { "Frank Lopes Pimenta" }
          let(:suggestion28) { "Frank Santos Pimenta" }
          let(:suggestion29) { "Frank Pimenta" }

          specify do
            suggestions = subject.__send__(:all).map(&:full_name)
            (1..29).to_a.each do |index|
              expect(suggestions).to include(__send__("suggestion#{index}"))
            end
          end
        end
      end
    end
    context "private instance methods" do
      let(:first_names) { "Frank Alessander Amorim" }
      let(:last_names) { "De Oliveira Lopes Santos Pimenta" }
      context "-build_full_name_combination" do
        specify { expect(subject.private_methods).to include(:build_full_name_combination) }
        specify { expect(subject.method(:build_full_name_combination).parameters).to eq([[:req, :middle_name_combination]])}
        specify "returns instance of NameCombination" do
          expect(subject.__send__(:build_full_name_combination, "Alessander de Oliveira")).to be_instance_of NameInstance
        end
        specify "returns correct full_name" do
          expect(subject.__send__(:build_full_name_combination, "Alessander De Oliveira").full_name).to eq "Frank Alessander De Oliveira"
        end
        specify "splits correctly among first_names and last_names" do
          full_name_combination = subject.__send__ :build_full_name_combination, "Alessander de Oliveira"
          expect(full_name_combination.first_names.all?{|first_name| subject.first_names.include? first_name}).to eq true
          expect(full_name_combination.first_names.none?{|first_name| subject.last_names.include? first_name}).to eq true
          expect(full_name_combination.last_names.all?{|last_name| subject.last_names.include? last_name}).to eq true
          expect(full_name_combination.last_names.none?{|last_name| subject.first_names.include? last_name}).to eq true
        end
        specify "discard name combinations without last names" do
          expect(subject.__send__ :build_full_name_combination, "Alessander Amorim").to eq(nil)
        end
      end
      context "-full_name_combinations" do
        specify { expect(subject.private_methods).to include(:full_name_combinations) }
        specify { expect(subject.method(:full_name_combinations).parameters).to eq([]) }
        specify do
          expect(subject).to receive_message_chain(:middle_names_combinations, :map).and_yield "Alessander de Oliveira"
          expect(subject).to receive(:build_full_name_combination).with("Alessander de Oliveira").and_return(
            [NameCombination.new(first_names: "Frank Alessander", last_names: "De Oliveira Pimenta")]
          )
          subject.__send__ :full_name_combinations
        end
        specify { expect(subject.__send__ :full_name_combinations).to be_instance_of(Array) }
        specify "discards nil from combinations (because of names without last_names)" do
          combinations = subject.__send__ :full_name_combinations
          expect(combinations.compact.size).to eq combinations.size
        end
      end
      context "-middle_names_combinations" do
        let(:middle_names) { ["Alessander", "De", "Oliveira"] }
        specify { expect(subject.private_methods).to include(:middle_names_combinations) }
        specify { expect(subject.method(:middle_names_combinations).parameters).to eq([]) }
        specify "receives  #middle_names" do
          expect(subject).to receive(:middle_names).and_call_original
          subject.__send__ :middle_names_combinations
        end
        context "for slightly_too_long name" do
          let(:name) { "Frank Alessander Amorim Oliveira Lopes Santos Pimenta" }

          let(:suggestion1)  { "Alessander Amorim Oliveira Lopes Santos" }
          let(:suggestion2)  { "Alessander Amorim Oliveira Santos" }
          let(:suggestion3)  { "Alessander Amorim Oliveira Lopes" }
          let(:suggestion4)  { "Alessander Amorim Lopes Santos" }
          let(:suggestion5)  { "Alessander Amorim Oliveira" }
          let(:suggestion6)  { "Alessander Amorim Lopes" }
          let(:suggestion7)  { "Alessander Amorim Santos" }

          let(:suggestion8)  { "Alessander Oliveira Lopes Santos" }
          let(:suggestion9)  { "Alessander Oliveira Santos" }
          let(:suggestion10) { "Alessander Oliveira Lopes" }
          let(:suggestion11) { "Alessander Lopes Santos" }
          let(:suggestion12) { "Alessander Oliveira" }
          let(:suggestion13) { "Alessander Lopes" }
          let(:suggestion14) { "Alessander Santos" }

          let(:suggestion15) { "Amorim Oliveira Lopes Santos" }
          let(:suggestion16) { "Amorim Oliveira Santos" }
          let(:suggestion17) { "Amorim Oliveira Lopes" }
          let(:suggestion18) { "Amorim Lopes Santos" }
          let(:suggestion19) { "Amorim Oliveira" }
          let(:suggestion20) { "Amorim Lopes" }
          let(:suggestion21) { "Amorim Santos" }

          let(:suggestion22) { "Oliveira Lopes Santos" }
          let(:suggestion23) { "Oliveira Santos" }
          let(:suggestion24) { "Oliveira Lopes" }
          let(:suggestion25) { "Lopes Santos" }
          let(:suggestion26) { "Oliveira" }
          let(:suggestion27) { "Lopes" }
          let(:suggestion28) { "Santos" }
          let(:suggestion29) { "" }

          let(:suggestions) { subject.__send__ :middle_names_combinations }
          specify do
            (2..28).to_a.each do |index|
              expect(suggestions).to include(__send__("suggestion#{index}"))
            end
          end
          specify { expect(suggestions).not_to include(suggestion29) }
        end
      end
    end
  end
end
