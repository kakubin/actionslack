# frozen_string_literal: true

RSpec.describe ActionSlack::Base do
  describe '.notify' do
    subject { described_class.notify }

    before do
      allow(doubled_instance).to receive(:url).and_return('url')
      allow(doubled_instance).to receive(:message).and_return('message')
      allow(described_class).to receive(:create).and_return(doubled_instance)
    end

    let(:doubled_instance) { double }

    it 'call ActionSlack::Notifier#notify' do
      expect(ActionSlack::Notifier).to receive(:notify).with(url: 'url', message: 'message').exactly(1)
      subject
    end
  end

  describe '.attributes=' do
    subject { described_class.attributes = attrs }

    it { expect(described_class.instance_variable_get(:@attributes)).to be_nil }

    context 'when it is not typeof array' do
      let(:attrs) { 1 }

      it do
        subject
        expect(described_class.instance_variable_get(:@attributes)).to eq [1]
      end
    end

    context 'when it is typeof array' do
      let(:attrs) { [1] }

      it do
        subject
        expect(described_class.instance_variable_get(:@attributes)).to eq [1]
      end
    end
  end

  describe '#url' do
    subject { instance.url }

    let(:instance) { described_class.new }

    before { instance.instance_variable_set(:@webhook, ActionSlack::Webhook.find('test1')) }

    it { is_expected.to be_a String }
  end

  describe 'child class' do
    subject { instance.message }

    let(:test_class) do
      Class.new(ActionSlack::Base) do
        self.attributes = [:name]

        def message
          "Hello, #{name}"
        end
      end
    end

    let(:instance) do
      instance = test_class.new
      instance.instance_variable_set(:@name, 'kakubin')
      instance.class_eval { attr_reader :name }

      instance
    end
    let(:expected) { 'Hello, kakubin' }

    it { is_expected.to eq expected }
  end
end
