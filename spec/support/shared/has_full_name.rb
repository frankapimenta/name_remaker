RSpec.shared_examples "has #full_name" do
  context "#full_name" do
    specify { expect(subject).to respond_to(:full_name).with_keywords(:separator, :reversed).with(0).arguments }
    specify { expect(subject.full_name).to be_instance_of(String) }
    context "not reversed" do
      context "without separator" do
        let(:full_name) { [first_names, last_names].join(' ') }
        specify { expect(subject.full_name).to eq full_name }
      end
      context "with separator" do
        let(:full_name) { [first_names, last_names].join('-') }
        specify { expect(subject.full_name(separator: '-')).to eq full_name }
      end
    end
    context "reversed" do
      context "without separator and reversed" do
        let(:full_name) { [last_names, first_names].join(' ') }
        specify { expect(subject.full_name(reversed: true)).to eq full_name }
      end
      context "with separator and reversed" do
        let(:full_name) { [last_names, first_names].join('-') }
        specify { expect(subject.full_name(separator: '-', reversed: true)).to eq full_name }
      end
    end
    specify { expect(subject.full_name).to be_frozen }
  end
end
