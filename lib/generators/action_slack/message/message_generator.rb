# frozen_string_literal: true

require 'rails/generators'

module ActionSlack
  module Generators
    class MessageGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc 'ActionSlack installation generator'
      argument :class_name, type: :string
      argument :webhook_name, type: :string

      def install
        template 'message.rb', "app/slack/#{class_name.underscore}.rb"
      end
    end
  end
end
