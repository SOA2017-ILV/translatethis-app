# frozen_string_literal: true

require_relative 'language_representer'
# Represents essential Translation information for API output
module TranslateThis
  # Representer Class for the Translation Entity
  class TranslationRepresenter < Roar::Decorator
    include Roar::JSON

    property :translated_text
    property :target_lang
    property :target_lang_code
    property :img_link
    property :label_text
  end
end
