# frozen_string_literal: true

module TranslateThis
  module Views
    # View object for a single translation
    class Translation
      def initialize(translation)
        @translation = translation
      end

      def label_text
        @translation.label_text
      end

      def translated_text
        @translation.translated_text
      end

      def target_lang
        @translation.target_lang
      end

      def target_lang_code
        @translation.target_lang_code
      end

      def img_link
        @translation.img_link
      end
    end
  end
end
