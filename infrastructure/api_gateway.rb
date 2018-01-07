# frozen_string_literal: true

require 'net/http/post/multipart'
require 'http'

module TranslateThis
  # translate this gateway
  class ApiGateway
    class ApiResponse
      HTTP_STATUS = {
        200 => :ok,
        201 => :created,
        202 => :processing,
        204 => :no_content,

        403 => :forbidden,
        404 => :not_found,
        400 => :bad_request,
        409 => :conflict,
        422 => :cannot_process,

        500 => :internal_error
      }.freeze

      attr_reader :status, :message

      def initialize(code, message)
        @code = code
        @status = HTTP_STATUS[code]
        @message = message
      end

      def ok?
        HTTP_STATUS[@code] == :ok
      end

      def processing?
        HTTP_STATUS[@code] == :processing
      end
    end

    def initialize(config = TranslateThis::App.config)
      @config = config
    end

    def send_img_target(image, target)
      call_api_multipart_img('translate', image, target)
    end

    def all_languages
      call_api(:get, 'language')
    end

    def additional_images(labels)
      call_api(:post, 'additional_images', { labels: labels} )
    end

    def call_api(method, resources, params = {})
      url_route = [@config.api_url, resources].flatten.join '/'
      result = HTTP.send(method, url_route, json: params)
      # raise(result.parse['message']) if result.code >= 300
      res_hash = JSON.parse(result.body.to_s)
      raise(res_hash['message']) if result.code >= 300
      ApiResponse.new(result.code, res_hash['message'])
    end

    def call_api_multipart_img(route, image, target)
      url_route = [@config.api_url, route].flatten.join '/'
      url = URI.parse(url_route)
      req_params = {}
      req_params['img'] = UploadIO.new(image[:tempfile],
                                       image[:content_type],
                                       image[:filename])
      req_params['target_lang'] = target
      result = Net::HTTP.start(
        url.host,
        url.port,
        use_ssl: url.scheme == 'https') do |http|
          req = Net::HTTP::Post::Multipart.new(url, req_params)
          http.request(req)
        end
      # TODO: Check if this Raise is working
      res_hash = JSON.parse(result.body.to_s)
      raise(res_hash['message']) if result.code.to_i >= 300
      ApiResponse.new(result.code.to_i, res_hash['message'])
    end
  end
end
