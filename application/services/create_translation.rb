# frozen_string_literal: true

require 'dry/transaction'

module TranslateThis
  # Transaction to create Translation in API
  class CreateTranslation
    include Dry::Transaction

    step :validate_input
    step :create_translation

    def validate_input(input)
      if input.success?
        Right(img: input[:img], target_lang: input[:target_lang])
      else
        Left(input.errors.values.join('; '))
      end
    end

    def create_translation(input)
      ApiGateway.new.send_img_target(input[:img], input[:target_lang])
      Right(input)
    rescue StandardError => error
      Left(error.to_s)
    end
  end
end