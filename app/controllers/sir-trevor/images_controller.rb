module SirTrevor
  class ImagesController < ::ApplicationController
    def create

      uploaded_file = File.open(file.tempfile.to_path.to_s, 'r')

      image = Image.new 
      image.file = uploaded_file

      if image.save
        FileUtils.rm uploaded_file
        render :json => image
      else
        render :json => image.errors
      end
      
    end 
  end
end