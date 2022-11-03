# frozen_string_literal: true

module ActionSlack
  class Notifier
    def self.notify(url:, message:)
      Slack::Notifier.new(url).post(text: message)
    end
  end
end
