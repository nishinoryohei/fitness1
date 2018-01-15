class ItemsController < ApplicationController
	before_action :set_item, only:[:show,:edit,:update,:destroy]
	def new
		@item = Item.new
		@item.build_category
	end
	def create
		@item = Item.new(item_params)
		@item.user_id = current_user.id
		respond_to do |format|
			if @item.save
				@category = Category.new
			 	 @id = @item.id
				format.html
				format.js
			else
				render :new
			end
		end
	end
	def index 
		@items = Item.page(params[:page]).includes(:category)
		             .cheaper(params[:max_price].presence)
		             .expensive(params[:min_price].presence)
		             .search_keyword(params[:keyword].presence)
		             .sort_by_genre(params[:genre].presence)

	end
	def show
	end
	def edit
	end
	def update
	end
	def destroy
	end
	private
	def set_item
		@item = Item.find(params[:id])
	end
	def item_params
		params.require(:item).permit(:name,:description,:price)
	end
end
