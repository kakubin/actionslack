# frozen_string_literal: true

RSpec.describe ActionSlack::Webhook do
  describe '.find' do
    subject { described_class.find(webhook_name) }

    context 'if webhook exist' do
      let(:webhook_name) { 'test1' }

      it { is_expected.to be_a described_class }
      it do
        webhook = subject
        expect(webhook.name).to eq 'test1'
        expect(webhook.url).to eq 'http://localhost:3030'
      end
    end

    context 'if webhook not exist' do
      let(:webhook_name) { nil }

      it { is_expected.to be_nil }
    end
  end
end
