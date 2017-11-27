# frozen_string_literal: true

module TranslateThis
  module Views
    # View object for a single repo's Github project
    class Language
      def initialize(language)
        @language = language
      end

      def name
        @language.name
      end

      def code
        @language.code
      end
    end
  end
end
