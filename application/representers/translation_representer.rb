# frozen_string_literal: true

# Represents essential Collaborator information for API output
# USAGE:
#   translation = # Get from gateway
#   CollaboratorRepresenter.new(OpenStruct.new).from_json translation
module TranslateThis
  class TranslateRepresenter < Roar::Decorator
    include Roar::JSON

    property :translated_text
    property :target_language
    property :label
  end
end
