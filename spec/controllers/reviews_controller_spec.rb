require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
	let(:user) { User.find(1) }
	before do
		login_user user
	end 
	describe 'POST#create' do
		context '有効なパラメータの場合' do
			before do
				@review = attributes_for(:review)
				post :create, params:{ item_id: 1, review: @review }
			end
			it 'リクエストが302になること' do
				expect(response.status).to eq 302
			end
			it 'saveしてitem/showにリダイレクトすること' do
				expect(response).to redirect_to item_path(1)
			end
			it 'データベースに登録されること' do
				expect{
					post :create, params:{ item_id: 1, review: @review }
				}.to change(Review, :count).by(1)
			end
		end
		context '無効なパラメータの場合' do
			before do
				@invalid_review = attributes_for(:invalid_review)
				post :create, params:{ item_id: 1, review: @invalid_review }
			end
			it 'データベースに登録されないこと' do
				expect{
					post :create, params:{ item_id: 1, review: @invalid_review }
				}.not_to change(Review, :count)
			end
		end
	end
	describe 'DELETE#destroy' do
		let(:review) { create(:review) }
		before do
			delete :destroy, params:{ id: review }
		end
		it 'リクエストが302になること' do
			expect(response.status).to eq 302
		end
		it 'item_pathにリダイレクトすること' do
			expect(response).to redirect_to item_path(id: 1)
		end
	end
end
