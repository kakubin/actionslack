# frozen_string_literal: true

require 'forwardable'

module ActionSlack
  class Base
    extend Forwardable

    def_delegators :webhook, :url

    class << self
      def notify(**kargs)
        instance = create(**kargs)

        if ActionSlack.configuration.async
          SendJob.perform_later(url: instance.url, message: instance.message)
        else
          Notifier.notify(url: instance.url, message: instance.message)
        end
      end

      def attributes=(attrs)
        @attributes = Array.wrap(attrs)
      end

      private

      def create(**kargs)
        instance_attributes = @attributes.presence || []

        missing_arguments = instance_attributes - kargs.keys
        raise ArgumentError, "missing keywords: #{missing_arguments.join(', ')}" if missing_arguments.present?

        instance = new

        instance_attributes.each do |instance_attribute|
          instance.instance_variable_set(:"@#{instance_attribute}", kargs[instance_attribute])
          instance.class_eval { attr_reader :"#{instance_attribute}" }
        end

        instance
      end
    end

    private

    def webhook_name
      raise NotImplementedError
    end

    def webhook
      @webhook ||= Webhook.find(webhook_name)
    end

    def message
      raise NotImplementedError
    end
  end
end
