# frozen_string_literal: true

module TranslateThis
  module Views
    # View object to capture progress bar information
    class AdditionalImagesView
      def initialize(all_images)
        @all_images = all_images
      end

      def none?
        @all_images.additional_images.none?
      end

      def any?
        @all_images.additional_images.any?
      end

      def collection
        @all_images.additional_images
                   .map { |image| AdditionalImage.new(image) }
      end
    end
  end
end
