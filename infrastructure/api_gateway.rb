# frozen_string_literal: true

require 'net/http/post/multipart'

module TranslateThis
  # translate this gateway
  class ApiGateway
    def initialize(config = TranslateThis::App.config)
      @config = config
    end

    def send_img_target(image, target)
      call_api(:post, 'translate', image, target)
    end

    def call_api(method, route, image, target)
      url_route = [@config.api_url, route].flatten.join '/'
      url = URI.parse(url_route)
      req_params = Hash.new
      req_params["img"] = UploadIO.new(image[:tempfile], image[:content_type], image[:filename])
      req_params["target_lang"] = target
      result = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') do |http|
        req = Net::HTTP::Post::Multipart.new(url, req_params)
        http.request(req)
      end
      raise(result.body.to_s) if result.code.to_i >= 300
      result.body.to_s
    end
  end
end
