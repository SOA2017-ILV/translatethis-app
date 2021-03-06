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
    plugin :flash

    use Rack::Session::Cookie, secret: config.SESSION_SECRET

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
          languages_json = ApiGateway.new.all_languages.message
          all_languages = LanguagesRepresenter
                          .new(OpenStruct.new)
                          .from_json languages_json
          languages = Views::AllLanguages.new(all_languages)
          view 'home', locals: { languages: languages, translations: nil }
        end
        # Receives params 'img' and 'target_lang'
        routing.post do
          create_request = Forms::TranslationRequest.call(routing.params)
          result = CreateTranslation.new.call(create_request)
          if result.success?
            flash.now[:notice] = 'Your image was translated!'
          else
            flash.now[:error] = result.value
          end
          translations_json = result.value
          all_translations = TranslationsRepresenter
                             .new(OpenStruct.new)
                             .from_json translations_json
          translations_views = Views::AllTranslations.new(all_translations)
          puts translations_views.any?
          if translations_views.none?
            flash.now[:error] = 'No Translations Found'
          end
          render :translations, locals: { translations: translations_views }
        end
      end

      routing.on 'additional_images' do
        routing.get do
          create_request = Forms::AdditionalImagesRequest.call(routing.params)
          result = GetAdditionalImages.new.call(create_request)
          if result.success?
            result = result.value
            view_info = { result: result }
            if result.processing?
              view_info[:processing] = Views::ProcessingView.new(result)
            else
              additional_images = AdditionalImagesRepresenter.new(OpenStruct.new)
                                                             .from_json result.message
              images_view = Views::AdditionalImagesView
                            .new(additional_images)
              view_info[:images] = images_view
            end
            render :additional_images, locals: view_info
          end
        end
      end

      routing.on 'languages' do
        routing.get do
          languages = ApiGateway.new.all_languages.message
          # all_languages = TranslateThis::LanguageRepresenter.new
          # view 'home', locals: { languages: all_languages }
          languages
        end
      end
    end
  end
end
