# frozen_string_literal: true

module ActionSlack
  class Configuration
    attr_accessor :filepath, :async

    def self.set_default(name, default)
      define_method name do
        @configuration[name]
      end

      define_method :"#{name}=" do |value|
        @configuration[name] = value
      end

      default_configuration[name] = default
    end

    def self.default_configuration
      @default_configuration ||= {}
    end

    def initialize
      @configuration = self.class.default_configuration.dup
    end

    set_default(:filepath, 'config/slack_webhooks.yml')
    set_default(:async, true)
    set_default(:env, :development)
  end
end
