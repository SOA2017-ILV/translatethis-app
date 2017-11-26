# frozen_string_literal: true

require 'roda'
require 'slim'

module TranslateThis
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'presentation/views'
    plugin :assets, css: 'style.css', js: 'app.js', path: 'presentation/assets'
    plugin :halt
    opts[:root] = 'presentation/assets'
    plugin :public, root: 'static'

    route do |routing|
      routing.assets
      routing.public
      # routing.static
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
          routing.halt(400) if image.nil? || target.nil?
          ApiGateway.new.send_img_target(image, target)
        end
      end

      routing.on 'languages' do
        routing.get do
          languages = ApiGateway.new.all_languages
          # all_languages = TranslateThis::LanguageRepresenter.new
          # view 'home', locals: { languages: all_languages }
          languages
        end
      end
    end
  end
end
