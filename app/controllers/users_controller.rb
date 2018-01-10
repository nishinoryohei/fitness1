class UsersController < ApplicationController
	def show
		@user = User.find(current_user.id)
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
