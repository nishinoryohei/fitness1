class ReviewsController < ApplicationController
	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.item_id = params[:item_id]
		if @review.save
			redirect_to item_path(params[:item_id])
		else
			redirect_to item_path(params[:item_id])
		end
	end
	def destroy
		@review = Review.find(params[:id])
		id = @review.item_id
		@review.delete
		redirect_to item_path(id)
	end
	private
	def review_params
		params.require(:review).permit(:content,:score)
	end
end
