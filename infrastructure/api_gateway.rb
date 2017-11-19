# frozen_string_literal: true

require 'http'

module TranslateThis
  # translate this gateway
  class ApiGateway
    def initialize(config = TranslateThis::App.config)
      @config = config
    end

    def send_img_target(image, target)
      call_api(:post, image, target)
    end

    def call_api(method, image, target)
      url_route = [@config.api_url]
    #TODO needs to change to reflect monad structure
      result = HTTP.send(method,
                         url_route,
                         body: 'img=' + image + '&target_lang=' + target)
      raise(result.to_s) if result.code >= 300
      result.to_s
    end
  end
end
