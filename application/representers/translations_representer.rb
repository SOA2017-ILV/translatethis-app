# frozen_string_literal: true

require_relative 'translation_representer'

# Represents essential Translation information for API output
module TranslateThis
  # Representer Class for the Translation Entity
  class TranslationsRepresenter < Roar::Decorator
    include Roar::JSON

    collection :translations, extend: TranslationRepresenter, class: OpenStruct
  end
end
