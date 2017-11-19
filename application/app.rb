# frozen_string_literal: true

require 'roda'
require 'slim'

module TranslateThis
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'presentation/views'
    plugin :assets, css: 'style.css', path: 'presentation/assets'

    route do |routing|
      routing.assets
      app = App

      #  / route
      routing.root do
        routing.redirect '/translate'
      end
      # /translate/ route
      routing.on 'translate' do
        routing.get do
          view 'home'
        end
        routing.post do
          image = routing.params['img']
          target = routing.params['target_lang']
          halt 400 if image.empty? || target.empty?
          ApiGateway.new.send_img_target(image, target)
        end
      end
    end
  end
end
