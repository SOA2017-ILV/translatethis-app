# frozen_string_literal: true

# Represents essential Repo information for API output
module TranslateThis
  class ImageRepresenter < Roar::Decorator
    include Roar::JSON

    property :image_url
    property :name
    collection :labels
  end
end
