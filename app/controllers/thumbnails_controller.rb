class ThumbnailsController < ApplicationController
	before_action :trainer_only
	def create
		@thumbnail = Thumbnail.new(thumbnail_params)
		if @thumbnail.save
			redirect_to new_item_path
		else
			@item = Item.first
			@item.delete
			redirect_to new_item_path
		end
	end
	private
	def thumbnail_params
		params.require(:thumbnail).permit(:image,:item_id)
	end
end
