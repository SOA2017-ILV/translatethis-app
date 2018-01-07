# frozen_string_literal: true

require 'dry/transaction'

module TranslateThis
  # Transaction to get additional images in API
  class GetAdditionalImages
    include Dry::Transaction

    step :validate_input
    step :get_additional_images

    def validate_input(input)
      if input.success?
        Right(labels: input[:labels])
      else
        Left(input.errors.values.join('; '))
      end
    end

    def get_additional_images(input)
      res = ApiGateway.new.additional_images(input[:labels])
      Right(res)
    rescue StandardError => error
      Left(error.to_s)
    end
  end
end
