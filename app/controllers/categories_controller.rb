class CategoriesController < ApplicationController
	def create
		@category = Category.new(category_params)
		respond_to do |format|
			if @category.save
				@thumbnail = Thumbnail.new
				@id = @category.item_id
				format.js
	    	else
	    		redirect_to new_item_path
			end
		end
	end
	private
	def category_params
		params.require(:category).permit(:genre,:keyword,:item_id)
	end
end
