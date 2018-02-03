class TrainingsController < ApplicationController
	before_action :set_user_last_training, only:[:edit,:update]
	def new
		@user = User.find(params[:user_id])
		chart_data
		@training = Training.new
		respond_to do |format|
			format.html
			format.js
		end
 	end
	def create
		@training = Training.new(training_params)
		chart_data
		@training.user_id = current_user.id
		if @training.save
			redirect_to user_path(current_user.id)
		else
		    render 'new.js'
		end
	end
	def edit
		respond_to do |format|
			format.html
			format.js
		end
	end
	def update
		if @last_training.update(training_params)
			@last_training.update(fruition: goal_achievement?(@last_training))
			redirect_to new_user_trainings_path(current_user.id)
		else
			render 'edit.js'
		end
	end
	private
	def training_params
		params.require(:training).permit(:progress,:goal,:fruition,:user_id)
	end
	def goal_achievement? training
		training.goal < training.progress		
	end
	def set_user_last_training
		@last_training = Training.where(user_id: current_user.id).first
	end
	def chart_data
		@goal_chart = Training.chart_goal(current_user.id).reverse
		@progress_chart = Training.chart_progress(current_user.id).reverse
		#chart_goal,chart_progressメソッドはtraining.rbに記載
	end
end
