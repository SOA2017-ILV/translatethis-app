# frozen_string_literal: true

require_relative 'additional_image_representer'

# Represents essential Language information for API output
module TranslateThis
  # Representer Class for the Language Entity
  class AdditionalImagesRepresenter < Roar::Decorator
    include Roar::JSON

    collection :additional_images, extend: AdditionalImageRepresenter, class: OpenStruct
  end
end
