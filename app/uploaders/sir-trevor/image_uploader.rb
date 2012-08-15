require 'digest/md5'

module SirTrevor

  class ImageUploader < CarrierWave::Uploader::Base
    
    include CarrierWave::MiniMagick
    storage :file

    def store_dir
      "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
    
    ImageSizes::General.styles.each do |general_image_style|
      version general_image_style do
        process :resize_to_fill => ImageSizes::General.size_for(general_image_style)
      end
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

    def filename
      digest = Digest::MD5.hexdigest(Time.current.to_i.to_s)
      "#{digest[0..15]}_#{original_filename}"
    end

    def as_json(options = nil)
      {
        :url => url,
      }.merge(
        ImageSizes::General.styles.inject({}) do |h, general_image_style|
          h.merge!(general_image_style.to_sym => {
            :url => versions[general_image_style].url
          })
        end
      )
    end
    
  end

end