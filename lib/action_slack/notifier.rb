# frozen_string_literal: true

module ActionSlack
  module Notifier
    module_function

    def notify(url:, message:)
      if ActionSlack.configuration.async?
        notify_later(url, message)
      else
        notify_now(url, message)
      end
    end

    private

    def notify_now(url, message)
      Slack::Notifier.new(url).post(text: message)
    end

    def notify_later(url, message)
      SendJob.perform_later(url: url, message: message)
    end
  end
end
