# frozen_string_literal: true

require 'dry-validation'

module TranslateThis
  module Forms
    AdditionalImagesRequest = Dry::Validation.Form do
      configure do
        config.messages_file = File.join(__dir__,
                                         'errors/additional_images_request.yml')
      end

      required(:labels).filled(:array?)
    end
  end
end
