# frozen_string_literal: true

require 'rails/generators'

module ActionSlack
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc 'ActionSlack installation generator'

      def install
        template 'initializer.rb', 'config/initializers/action_slack.rb'
      end
    end
  end
end
