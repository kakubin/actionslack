# frozen_string_literal: true

module ActionSlack
  class Webhook
    attr_reader :name, :url

    class << self
      def webhooks
        @webhooks ||= load_webhooks
      end

      def find(name)
        webhooks.find { |webhook| webhook.name == name }
      end

      private

      def load_webhooks
        filepath = ActionSlack.configuration.filepath
        raise unless File.exist?(filepath)

        erb = ERB.new(File.read(filepath))
        yml = load_yaml(erb.result)
        yml.map(&method(:new))
      end

      def load_yaml(src)
        if Psych::VERSION > '4.0'
          YAML.load(src, symbolize_names: true, aliases: true, freeze: true)
        else
          YAML.safe_load(src)
        end
      end
    end

    def initialize(webhook)
      @name = webhook[:name]
      @url = webhook[:url]
    end
  end
end
