class ThumbnailsController < ApplicationController
	before_action :trainer_only
	def create
		if Thumbnail.create_thumbnail_by(thumbnail_params)
			redirect_to new_item_path
		else
			@item = Item.first
			@item.delete
			redirect_to new_item_path
		end
	end
	private
	def thumbnail_params
		params.require(:thumbnail).permit({image:[]},:item_id)
	end
end
