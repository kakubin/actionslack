# frozen_string_literal: true

RSpec.describe ActionSlack::Notifier do
  describe '.notify' do
    subject { described_class.notify(url: url, message: message) }

    let(:url) { 'http://localhost:3000' }
    let(:message) { 'hello, world' }

    context 'when send in async' do
      before { ActionSlack.configuration.async = true }

      it do
        expect(described_class).to receive(:notify_later).with(url, message)
        subject
      end
    end

    context 'when send in sync' do
      before { ActionSlack.configuration.async = false }

      it do
        expect(described_class).to receive(:notify_now).with(url, message)
        subject
      end
    end
  end
end
