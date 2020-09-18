require 'spec_helper'

RSpec.describe ::Pipedrive::Person do
  subject { described_class.new('token') }
  context '#entity_name' do
    subject { super().entity_name }
    it { is_expected.to eq('persons') }
  end

  context '#find_by_name' do
    it 'should call #make_api_call with term' do
      expect(subject).to receive(:make_api_call).with(:get, 'find', {term: 'term', search_by_email: 0, start: 0})
      expect { |b| subject.find_by_name('term', &b)}.to yield_successive_args
    end
    it 'should call #make_api_call with term and search_by_email' do
      expect(subject).to receive(:make_api_call).with(:get, 'find', {term: 'term', search_by_email: 1, start: 0})
      expect { |b| subject.find_by_name('term', true, &b)}.to yield_successive_args
    end
    it 'should yield results' do
      expect(subject).to receive(:make_api_call).with(:get, 'find', {term: 'term', search_by_email: 0, start: 0}).and_return(::Hashie::Mash.new(data: [1,2], success: true))
      expect { |b| subject.find_by_name('term', &b)}.to yield_successive_args(1,2)
    end
  end

  context '#search' do
    it 'should call #make_api_call with search term' do
      expect(subject).to receive(:make_api_call).with(:get, 'search', {term: 'term', start: 0})
      expect { |b| subject.search('term', &b)}.to yield_successive_args
    end
  end
end
