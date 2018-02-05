class PersonalsController < ApplicationController
	before_action :set_personal, only:[:edit,:update]
	def new
		@personal = Personal.new
		@current_user_personal = Personal.find_by(user_id: current_user.id)
	end
	def create
		@personal = Personal.new(personal_params)
		@personal.user_id = current_user.id
		if @personal.save
			flash[:success] = '住所を登録しました'
			redirect_to new_personal_path
		else
			flash[:error] = '入力が不十分です'
			redirect_to new_personal_path
		end
	end
	def edit	
	end
	def update
		if @personal.update(personal_params)
			redirect_to new_personal_path
		else
			redirect_to new_personal_path
		end
	end
	private
	def personal_params
		params.require(:personal).permit(:tel,:state,:city,:address,:user_id)
	end
	def set_personal
		@personal = Personal.find(params[:id])
	end
end