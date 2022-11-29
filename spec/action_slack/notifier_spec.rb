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

      context 'if on testflight' do
        around do |e|
          tmp = ActionSlack.configuration.type
          ActionSlack.configuration.type = :testflight
          e.run
          ActionSlack.configuration.type = tmp
        end

        let(:expected_message) do
          <<~MSG
            [ActionSlack Test Posting]
            #{message}
          MSG
        end

        it do
          expect(described_class).to receive(:notify_later).with(url, expected_message)
          subject
        end
      end
    end

    context 'when send in sync' do
      before { ActionSlack.configuration.async = false }
      before { WebMock.stub_request(:post, /http/).to_return(status: 200) }

      it { is_expected.to be true }

      context 'if on testflight' do
        around do |e|
          tmp = ActionSlack.configuration.type
          ActionSlack.configuration.type = :testflight
          e.run
          ActionSlack.configuration.type = tmp
        end

        let(:expected_message) do
          <<~MSG
            [ActionSlack Test Posting]
            #{message}
          MSG
        end

        it { is_expected.to be_truthy }
      end
    end
  end
end
