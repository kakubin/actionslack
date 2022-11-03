# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'yaml'
require 'erb'
require 'slack-notifier'

module ActionSlack
  extend ActiveSupport::Autoload

  autoload :Configuration
  autoload :Webhook
  autoload :Notifier
  autoload :Base

  autoload :SendJob if const_defined?(:ActiveJob)

  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
