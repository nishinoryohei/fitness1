class ItemsController < ApplicationController
	before_action :sold_out, only:[:show]
	before_action :set_item, only:[:show,:edit,:update,:destroy]
	before_action :trainer_only, only:[:new,:create,:update,:destroy]
	def new
		@item = Item.new
	end
	def create
		@item = Item.new(item_params)
		@item.user_id = current_user.id
		if @item.save
			@category = Category.new
		 	@id = @item.id
		 	respond_to do |format|
				format.html
				format.js
			end
		else
			redirect_to new_item_path
		end
	end
	def index 
		@items = Item.page(params[:page]).per(27).includes(:category)
		             .cheaper(params[:max_price].presence)
		             .expensive(params[:min_price].presence)
		             .search_keyword(params[:keyword].presence)
		             .sort_by_genre(params[:genre].presence)

	end
	def show
		#--trainer--
		ids = @item.cart_items.map(&:user_id)
		@users = User.where(id: ids)
		#--customer--
		@cart_item = CartItem.new
		@review = Review.new
		@reviews = Review.where(item_id: @item.id)
	end
	def update
		if @item.update(item_params)
			redirect_to user_path(current_user)
		else
			redirect_to item_path(@item)
		end
	end
	def destroy
		@item.delete
		redirect_to user_path(current_user)
	end
	private
	def set_item
		@item = Item.find(params[:id])
	end
	def item_params
		params.require(:item).permit(:name,:description,:price,:stock)
	end
	def sold_out
		set_item
		if @item.stock == 0 && current_user.trainer == false
			redirect_to items_path
		end
	end
end
