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

      # GET / request
      routing.root do
        view 'home', locals: {}
      end

      routing.on 'translate' do
        routing.post do
        end
      end
    end
  end
end
