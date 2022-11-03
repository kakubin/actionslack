# frozen_string_literal: true

require 'active_support'
require 'yaml'
require 'erb'
require 'slack-notifier'

module ActionSlack
  extend ActiveSupport::Autoload

  autoload :Configuration
  autoload :Webhook
  autoload :Notifier

  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
