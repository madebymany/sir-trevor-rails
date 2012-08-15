module SirTrevor
	class Image < ActiveRecord::Base
	  self.table_name = 'sedit_images'
  	mount_uploader :file, ImageUploader
  	validates :file, :presence => true
	end
end
