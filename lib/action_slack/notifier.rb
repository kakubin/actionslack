# frozen_string_literal: true

module ActionSlack
  module Notifier
    module_function

    def notify(url:, message:)
      message = ActionSlack.configuration.testflight? ? "[ActionSlack Test Posting]\n#{message}\n" : message

      if ActionSlack.configuration.async?
        notify_later(url, message)
      else
        notify_now(url, message)
      end
    end

    def notify_now(url, message)
      if ActionSlack.configuration.local?
        ActionSlack.logger.debug { "Post to Slack webhook url: #{url}, message: \"#{message}\"" }
      else
        ActionSlack.logger.info { "Start posting to Slack webhook url: #{url}, message: \"#{message}\"" }
        Slack::Notifier.new(url).post(text: message)
        ActionSlack.logger.info 'Posted to Slack'
      end
    end

    def notify_later(url, message)
      SendJob.perform_later(url: url, message: message)
    end
  end
end
