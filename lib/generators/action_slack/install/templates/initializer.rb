# frozen_string_literal: true

ActionSlack.configure do |config|
  # config.filepath = "config/webhooks.yml"
  config.async = false
  config.type = Rails.env.production? :production : :local
end
