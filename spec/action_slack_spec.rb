# frozen_string_literal: true

RSpec.describe ActionSlack do
  describe '.configuration' do
    subject { described_class.configuration }

    it { is_expected.to be_a ActionSlack::Configuration }

    it 'return same object' do
      first_object_hash = subject.hash
      second_object_hash = subject.hash
      expect(first_object_hash).to be second_object_hash
    end
  end
end
