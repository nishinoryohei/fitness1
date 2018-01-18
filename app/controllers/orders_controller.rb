class OrdersController < ApplicationController
	include UsersHelper
	def new
		@order = Order.new
	end
	def create
		@order = Order.new(order_params)
		if order.save
			redirect_to root_path
		else
			render :new
		end
	end
	def pay
		total_fee = user_item_total_fee current_user
		order = Order.create(user_id: current_user.id, total_fee: total_fee)
   	 	Payjp.api_key = 'sk_test_9ce0c01596b2d56de3a3ac45'
    	charge = Payjp::Charge.create(
    	:amount => order.total_fee,
   	 	:card => params['payjp-token'],
    	:currency => 'jpy',
		)
    	order_item_purchased current_user
		redirect_to root_path, notice: "支払いが完了しました"
	end
	private
	def order_params
		params.require(:order).permit(:user_id,:total_fee)
	end
	def order_item_purchased user
 		user.cart_items.map{|f| 
 			if f.is_purchase == true
 				f.update( is_purchase: false)
 			end
 		}
	end
end
