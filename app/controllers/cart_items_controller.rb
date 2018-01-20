class CartItemsController < ApplicationController
	def create
		@cart_item = CartItem.new(cart_item_params)
		@cart_item.item_id = params[:item_id]
		@cart_item.user_id = current_user.id
		@cart_item.is_purchase = true
		if @cart_item.save
			item = Item.find(params[:item_id])
			item.update(stock: item.stock - @cart_item.quantity)
			redirect_to root_path
		else
			redirect_to item_path(params[:item_id])
		end
	end
	def destroy
		@cart_item = CartItem.where(item_id: params[:item_id])
		item = Item.find(params[:item_id])
		item.update(stock: item.stock + @cart_item.map{|f| f.quantity}.sum)
		@cart_item.delete_all
		redirect_to root_path
	end
	private
	def cart_item_params
		params.require(:cart_item).permit(:item_id,:user_id,:quantity,:is_purchase)
	end
end
