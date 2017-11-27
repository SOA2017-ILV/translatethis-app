# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

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
          languages_json = ApiGateway.new.all_languages
          all_languages = LanguagesRepresenter.new(OpenStruct.new).from_json languages_json
          languages = Views::AllLanguages.new(all_languages)

          view 'home', locals: { languages: languages, translations: nil }
        end
        routing.post do
          create_request = Forms::TranslationRequest.call(routing.params)
          result = CreateTranslation.new.call(create_request)
          puts 'a'
          puts result
          puts 'b'
          #image = routing.params['img']
          #target = routing.params['target_lang']
          #routing.halt(400) if image.nil? || target.nil?
          if result.success?
            #flash
          else
            #flash
          end
          languages_json = ApiGateway.new.all_languages
          all_languages = LanguagesRepresenter.new(OpenStruct.new).from_json languages_json
          languages = Views::AllLanguages.new(all_languages)
          puts result
          view 'home', locals: { languages: languages, translations: result }
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
