# frozen_string_literal: true

module TranslateThis
  module Views
    # View object for colelction of translations
    class AllTranslations
      def initialize(all_translations)
        @all_translations = all_translations
      end

      def none?
        @all_translations.translations.none?
      end

      def any?
        @all_translations.translations.any?
      end

      def collection
        @all_translations.translations
                         .map { |translation| Translation.new(translation) }
      end
    end
  end
end
