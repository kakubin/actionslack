# frozen_string_literal: true

module ActionSlack
  class SendJob < ActiveJob::Base
    def perform(url, message)
      Notifier.__send__(:notify_now, url, message)
    end
  end
end
