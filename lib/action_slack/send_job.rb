# frozen_string_literal: true

module ActionSlack
  class SendJob < ActiveJob::Base
    def perform(url:, message:)
      Notifier.notify(url: url, message: message)
    end
  end
end
