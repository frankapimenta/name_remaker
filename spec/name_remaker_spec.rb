require 'support/shared/names_data_context'

RSpec.describe NameRemaker do
  include_context 'names data context'

  context "module constants" do
    context "default first names constant" do
      # for easy test
      specify { expect(described_class.constants).to include(:DEFAULT_FIRST_NAMES) }
      specify { expect(described_class::DEFAULT_FIRST_NAMES).to eq "Tom Mark Antonio" }
    end
    context "default last names constant" do
      # for easy test
      specify { expect(described_class.constants).to include(:DEFAULT_LAST_NAMES) }
      specify { expect(described_class::DEFAULT_LAST_NAMES).to eq "Smith Grant Cruise" }
    end
  end
  context "module methods" do
    context "#remake" do
      specify { expect(described_class).to respond_to(:remake).with_keywords(:first_names, :last_names) }
      specify { expect(described_class.remake(first_names: first_names, last_names: last_names)).to be_instance_of(NameRemaker::Remake) }
      specify "discards extra keywords arguments" do
        expect(NameRemaker::Remake).to receive(:new).with(first_names: first_names, last_names: last_names)
        described_class.remake(first_names: first_names, last_names: last_names, a: :a, b: :b)
      end
    end
  end
end
