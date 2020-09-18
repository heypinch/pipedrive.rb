require 'spec_helper'

RSpec.describe ::Pipedrive::Organization do
  subject { described_class.new('token') }
  context '#entity_name' do
    subject { super().entity_name }
    it { is_expected.to eq('organizations') }
  end

  context '#search' do
    it 'should call #make_api_call with search term' do
      expect(subject).to receive(:make_api_call).with(:get, 'search', {term: 'term', start: 0})
      expect { |b| subject.search('term', &b)}.to yield_successive_args
    end
  end
end
