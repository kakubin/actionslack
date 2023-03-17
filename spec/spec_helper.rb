# frozen_string_literal: true

require 'active_job'
require 'action_slack'
require 'webmock'

WebMock.enable!

# require 'rspec/rails'

ActionSlack.configure do |config|
  config.filepath = 'spec/dummy/config/slack_webhooks.yml'
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
