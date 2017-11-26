# frozen_string_literal: true

require 'dry-validation'

module TranslateThis
  module Forms
    TranslationRequest = Dry::Validation.Form do

      required(:img).filled
      required(:target_lang).filled

      configure do
        config.messages_file = File
                               .join(__dir__, 'errors/translation_request.yml')
      end
    end
  end
end
