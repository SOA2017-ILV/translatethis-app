# frozen_string_literal: true

require 'dry-validation'

module TranslateThis
  module Forms
    TranslationRequest = Dry::Validation.Form do
      configure do
        config.messages_file = File
                               .join(__dir__, 'errors/translation_request.yml')

        def valid_img?(str)
          puts str[:type]
          (str.has_key? :type) && (str[:type] == 'image/jpeg') || (str[:type] == 'image/png')
        end
      end

      required(:img).filled
      required(:target_lang).filled

      rule(valid_img: [:img]) do |img|
        img.valid_img?
      end
    end
  end
end
