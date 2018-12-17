RSpec.shared_context "names data context", :shared_context => :metadata do
  subject { described_class.new(first_names: first_names, last_names: last_names) }

  let(:source)              { [NameRemaker::DEFAULT_FIRST_NAMES, NameRemaker::DEFAULT_LAST_NAMES].join(' ') }
  let(:full_name)           { source }
  let(:first_name)          { first_names.split(' ').first }
  let(:last_name)           { last_names.split(' ').last }
  let(:first_names)         { source.split(' ').first(3).join(' ') }
  let(:last_names)          { source.split(' ').last(3).join(' ') }
  let(:first_and_last_name) { [first_name, last_name].join(' ') }
  let(:middle_names)        { first_names.split(' ')[1..-1] + last_names.split(' ') }
  let(:names)               { source.split(' ') }
end
