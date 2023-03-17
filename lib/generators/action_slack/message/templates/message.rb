# frozen_string_literal: true

class <%= class_name.camelize %> < ActionSlack::Base
  self.attributes = []

  def webhook_name
    '<%= webhook_name || '' %>'
  end

  def message
    <<~MSG

    MSG
  end
end
