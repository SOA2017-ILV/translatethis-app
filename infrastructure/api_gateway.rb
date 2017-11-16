# frozen_string_literal: true

require 'http'

module TranslateThis
  # Class to interact with Translate This Api
  class ApiGateway
    def initialize(config = TranslateThis::App.config)
      @config = config
    end

    def call_api(method, resources)
      url_route = [@config.api_url, resources].flatten.join '/'

      result = HTTP.send(method, url_route)
      raise(result.to_s) if result.code >= 300
      result.to_s
    end
  end
end
