class Thumbnail < ApplicationRecord
	belongs_to :item, dependent: :delete
		mount_uploader :image,ThumbnailUploader
end
