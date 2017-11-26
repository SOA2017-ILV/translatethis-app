# frozen_string_literal: true

require_relative 'language_representer'

# Represents essential Language information for API output
module TranslateThis
  # Representer Class for the Language Entity
  class LanguagesRepresenter < Roar::Decorator
    include Roar::JSON

    collection :languages, extend: LanguageRepresenter, class: OpenStruct
  end
end
