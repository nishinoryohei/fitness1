class OrdersController < ApplicationController
	include UsersHelper
	def create
		if create_order_params false
			@item_ids = CartItem.current_cart_in_item_id current_user.id
			@items = Item.where(id: @item_ids)
			user_ids = @items.map(&:user_id).uniq
			UserMailer.order_customer(current_user,@items).deliver
			order_item_purchased current_user
			redirect_to root_path
		else
			redirect_to root_path
		end
	end
	def update
		@order = Order.find(params[:id])
		@order.update(payment_status: true)
		redirect_to root_path
	end
	def pay
		create_order_params true
   	 	Payjp.api_key = 'sk_test_9ce0c01596b2d56de3a3ac45'
    	charge = Payjp::Charge.create(
    	:amount => @order.total_fee,
   	 	:card => params['payjp-token'],
    	:currency => 'jpy',
		)
    	order_item_purchased current_user
		redirect_to root_path, notice: "支払いが完了しました"
	end
	private
	def create_order_params status
		total_fee = user_item_total_fee current_user
		@order = Order.create(user_id: current_user.id, total_fee: total_fee, payment_status: status)
	end
	def order_item_purchased user
 		user.cart_items.map{|f| 
 			if f.is_purchase == true
 				f.update( is_purchase: false)
 			end
 		}
	end
end
