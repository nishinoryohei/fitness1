class Thumbnail < ApplicationRecord
	belongs_to :item, dependent: :delete
		mount_uploader :image,ThumbnailUploader
	def self.create_thumbnail_by(params)
		return false if params[:image] == nil || params[:image].count >= 6 
		Thumbnail.transaction do
			params[:image].each do |image|
			new_image = Thumbnail.new(image: image, item_id: params[:item_id])
			return false unless new_image.save!
			end
		end
		true
	end
end
