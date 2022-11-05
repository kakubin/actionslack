# frozen_string_literal: true

RSpec.describe ActionSlack::SendJob do
  describe '#perform' do
    subject { described_class.perform_now(url, message) }

    let(:url) { 'http://localhost:3000' }
    let(:message) { 'message' }

    it do
      expect(ActionSlack::Notifier).to receive(:notify_now).with(url, message).exactly(1)
      subject
    end
  end
end
