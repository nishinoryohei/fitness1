class CategoriesController < ApplicationController
	before_action :trainer_only
	def create
		@category = Category.new(category_params)
		if @category.save
			@thumbnail = Thumbnail.new
			@id = @category.item_id
			respond_to do |format|
				format.js
			end
	   	else
	   		@item = Item.first
	   		@item.delete
	   		flash[:error] = 'カテゴリを選択してください'
	   		redirect_to new_item_path
		end
	end
	private
	def category_params
		params.require(:category).permit(:genre,:keyword,:item_id)
	end
end
