# frozen_string_literal: true

# Represents essential Translation information for API output
module TranslateThis
  # Representer Class for the Additional Image Entity
  class AdditionalImageRepresenter < Roar::Decorator
    include Roar::JSON

    property :label
    property :links
  end
end
