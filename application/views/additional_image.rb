# frozen_string_literal: true

module TranslateThis
  module Views
    # View object for a single language
    class AdditionalImage
      def initialize(image)
        @image = image
      end

      def label
        @image.label
      end

      def links
        @image.links
      end
    end
  end
end
