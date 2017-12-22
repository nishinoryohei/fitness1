class BodiesController < ApplicationController
	def new
		@body = Body.new
		respond_to do |format|
			format.html
			format.js
		end
	end
	def create
		@body = Body.new(body_params)
		respond_to do |format|
		@body.user_id = current_user.id
			if @body.save
				user_bmi_evaluation
				redirect_to user_path(current_user)
			else
				format.js { render :new }
			end
		end
	end
	private
	def body_params
		params.require(:body).permit(:weight,:height,:bmi,:score,:user_id)
	end
	private
	def user_bmi_evaluation
		@user = User.find(current_user.id)
		@current_body = @user.bodies.last
		case @current_body.bmi.to_i
		when 0..18.5 
			@user.update(status: 1)
		when 18.5..25
			@user.update(status: 2)
		when 25..30
			@user.update(status: 3)
		when 30..35
			@user.update(status: 4)
		when 35..40
			@user.update(status: 5)
		when 40..1000
			@user.update(status: 6)
		end
	end
end
