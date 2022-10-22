# frozen_string_literal: true

module ActionSlack
  class Configuration
    attr_accessor :filepath

    def initialize
      @filepath = 'path/to/config'
      async!
    end

    def async!
      @async = true
    end

    def sync!
      @async = false
    end

    def async?
      @async
    end
  end
end
