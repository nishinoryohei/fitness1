class ThumbnailsController < ApplicationController
	before_action :trainer_only, only:[:create]
	def create
		if Thumbnail.create_thumbnail_by(thumbnail_params)
			flash[:success] = '正しく出品されました'
			redirect_to new_item_path
		else
			@item = Item.first
			@item.delete
			flash[:error] = '画像を選択してください　画像は５枚以下です'
			redirect_to new_item_path
		end
	end
	def show
		@thumbnail = Thumbnail.find(params[:id])
		respond_to do |format|
			format.js
		end
	end
	private
	def thumbnail_params
		params.require(:thumbnail).permit({image:[]},:item_id)
	end
end
