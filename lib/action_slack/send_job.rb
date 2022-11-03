# frozen_string_literal: true

module ActionSlack
  class SendJob < ActiveJob::Base
    def perform(url:, message:)
      Notifier.notify(url, message)
    end
  end
end
