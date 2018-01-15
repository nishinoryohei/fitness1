class CommentsController < ApplicationController
	def new
		@trainers = User.trainers
		@comment = Comment.new
		respond_to do |format|
			format.html
			format.js
		end
	end
	def create
		@comment = Comment.new(comment_params)
		@comment.server_id = current_user.id
		if @comment.save
			@talk = talk_content @comment.receiver_id
			#talk_contestメソッドはにapplication_controllerに記載
			render 'users/_talk-room'
		else
			redirect_to inbox_user_path(current_user.id) 
		end
	end
	private
	def comment_params
		params.require(:comment).permit(:content,:server_id, :receiver_id)
	end
end
