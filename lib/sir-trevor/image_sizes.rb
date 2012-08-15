module SirTrevor
  module ImageSizes
    
    class ImageSizeContainer

      def self.styles
        styles_and_sizes.keys
      end

      def self.size_for(style)
        styles_and_sizes[style.to_sym] || [nil, nil]
      end

      def self.placeholder?(image_path, style)
        image_path == placeholder_for(style)
      end

    end
    
    class General < ImageSizeContainer
      
      def self.styles_and_sizes
        @styles_and_sizes ||= Sedit.config.image_sizes
      end

      def self.placeholder_for(style)
        if self.styles.include?(style.to_sym)
          "sir-trevor/placeholders/#{style}_placeholder.jpg"
        else
          "sir-trevor/placeholders/placeholder.jpg"
        end
      end

    end

  end
end