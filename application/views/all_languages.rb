# frozen_string_literal: true

module TranslateThis
  module Views
    # View object for colelction of Github projects
    class AllLanguages
      def initialize(all_languages)
        @all_languages = all_languages
      end

      def none?
        @all_languages.languages.none?
      end

      def any?
        @all_languages.languages.any?
      end

      def collection
        @all_languages.languages.map { |language| Language.new(language) }
      end
    end
  end
end
