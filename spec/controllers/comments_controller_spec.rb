require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	let(:user) { User.find(1) }
	before do
		login_user user
	end
	describe 'GET#new' do
		before do
			get :new, xhr: true
		end
		render_views
		it 'リクエストが200になること' do
			expect(response.status).to eq 200
		end
		it '@commentにパラメータを割り当てること' do
			expect(assigns(:comment)).to be_a_new(Comment)
		end
		it 'new.jsを読み込むこと' do
			expect(response).to render_template :new
		end
		it '_form.htmlを表示すること' do
			expect(response).to render_template(partial: '_form')
		end
	end
	describe 'POST#create' do
		context '有効なパラメータの場合' do
			before do
				@comment = attributes_for(:comment)
				post :create, params:{ comment: @comment }
			end
			it 'saveしてuser/_talk-roomを表示すること' do
				expect(response).to redirect_to inbox_user_path(1)
			end
			it 'データベースに登録されること' do
				expect{
					post :create, params:{ comment: @comment }
				}.to change(Comment, :count).by(1)
			end 
		end
		context '無効なパラメータの場合' do
			before do
				@invalid_comment = attributes_for(:invalid_comment)
				post :create, params:{ comment: @invalid_comment }
			end
			it 'new.jsにrenderすること' do
				expect(response).to redirect_to inbox_user_path(1)
			end
			it 'データベースに登録されないこと' do
				expect{
					post :create, params:{ comment: @invalid_comment }
				}.not_to change(Comment, :count)
			end
		end
	end
end
