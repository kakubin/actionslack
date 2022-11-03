# frozen_string_literal: true

RSpec.describe ActionSlack::Configuration do
  describe '.set_default' do
    subject { described_class.set_default(:key, :new_value) }

    it 'will be changed' do
      expect(described_class.default_configuration[:key]).to be_nil
      subject
      expect(described_class.default_configuration[:key]).to be :new_value
    end
  end
end
