class UsersController < ApplicationController
	def show
		@user = User.find(current_user.id)
		item_ids = @user.cart_items.map{|f|
			if f.is_purchase == true
				f.item_id
			end
		 }
		@cart_in_items = Item.where(id: item_ids)
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
