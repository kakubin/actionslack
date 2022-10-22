# frozen_string_literal: true

require 'active_support'

module ActionSlack
  extend ActiveSupport::Autoload

  autoload :Configuration
  autoload :Webhook

  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
