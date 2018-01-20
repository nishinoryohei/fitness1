class UsersController < ApplicationController
	def show
		@user = User.find(current_user.id)
		#--trainer--
		@exhibit_item = Item.where(user_id: @user.id).page(params[:page]).per(15).includes(:category)
		@still_payment_orders = Order.where(payment_status: false)
		#--customer--
		item_ids = CartItem.current_cart_in_item_id @user.id
		@cart_in_items = Item.where(id: item_ids)
		@weight_chart = Body.chart_weight(@user.id).reverse
	end
	def inbox
		@user = User.find(current_user.id)
		@during_a_call = User.during_a_call @user
		#during_a_callメソッドはuser.rbに記載
	end
	def inbox_show
		@talk = talk_content (params[:id])
		respond_to do |format|
			format.html
			format.js
		end
	end
end
