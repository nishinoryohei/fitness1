require 'rails_helper'

RSpec.describe BodiesController, type: :controller do
	let(:user) { User.find(1) }
	before do
		login_user user
	end
	describe 'GET#new' do
		before do
			get :new, xhr: true
		end
		render_views
		it 'リクエストは200になること' do
			expect(response.status).to eq 200
		end
		it 'new.jsを読み込むこと' do
			expect(response).to render_template :new
		end
		it '@bodyにパラメータを割り当てること' do
			expect(assigns(:body)).to be_a_new(Body)
		end
		it '_form.htmlを表示すること' do
			expect(response).to render_template(partial: '_form')
		end
	end
	describe 'POST#create' do
		context '有効なパラメータの場合' do
			before do
				@body = attributes_for(:body)
			end
			it 'saveしてuser/showページにリダイレクトする' do
				post :create, params:{ user_id: 1, body: @body }
				expect(response).to redirect_to user_path(id: 1)
			end
			it 'データベースにbodyが登録されること' do
				expect{
						post :create, params:{ user_id: 1, body: @body }
				}.to change(Body, :count).by(1)
			end
		end
		context'無効なパラメータの場合' do
			before do
				@invalid_body = attributes_for(:invalid_body)
			end
			it 'new.jsにrenderすること' do
				post :create, params:{ user_id: 1, body: @invalid_body }
				expect(response).to render_template 'new.js'
			end
			it 'データベースにbodyが登録されないこと' do
				expect{
					post :create, params:{ user_id: 1, body: @invalid_body }
				}.not_to change(Body, :count)
			end
		end
	end
end
