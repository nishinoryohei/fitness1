require 'rails_helper'

RSpec.describe TrainingsController, type: :controller do
	let(:user) { User.find(1) }
	before do
		login_user user
	end
	describe 'GET#new' do
		before do
			get :new, params:{ user_id: 1 }
		end
		it 'リクエストは200になること' do
			expect(response.status).to eq 200
		end
		it 'new.htmlを表示すること' do
			expect(response).to render_template :new
		end
		it '@trainingにパラメータを割り当てること' do
			expect(assigns(:training)).to be_a_new(Training)
		end
		context 'Ajaxの処理' do
			before do
				get :new, params:{ user_id: 1 }, xhr: true
			end
			render_views
			it 'new.jsを読み込むこと' do
				expect(response).to render_template :new
			end
			it '_form.htmlを表示すること' do
				expect(response).to render_template(partial: '_form')
			end
		end
	end
	describe 'POST#create' do
		context '有効なパラメータの場合' do
			before do
				@training = attributes_for(:training)
			end
			it 'saveしてuser/showページにリダイレクトする' do
				post :create, params:{ user_id: 1, training: @training }
				expect(response).to redirect_to user_path(id: 1)
			end
			it 'データベースに登録されること' do
				expect{
					post :create, params:{ user_id: 1, training: @training }
				}.to change(Training, :count).by(1)
			end
		end
		context '無効なパラメータの場合' do
			before do
				@invalid_training = attributes_for(:invalid_training)
			end
			it 'new.jsにrenderすること' do
				post :create, params:{ user_id: 1, training: @invalid_training }
				expect(response).to render_template 'new.js'
			end
			it 'データベースに登録されないこと' do
				expect{
					post :create, params:{ user_id: 1, training: @invalid_training }
				}.not_to change(Training, :count)
			end
		end
	end
	describe 'GET#edit' do
		before do
			get :edit, params:{ user_id: 1 },xhr: true
		end
		render_views
		it 'リクエストは200になること' do
			expect(response.status).to eq 200
		end
		it 'edit.jsを読み込むこと' do
			expect(response).to render_template :edit
		end
		it '_update.htmlを表示すること' do
			expect(response).to render_template(partial: '_update')
		end
	end
	describe 'PATCH#update' do
		context '有効なパラメータの場合' do
			before do
				@training = attributes_for(:training)
				patch :update, params:{ user_id: 1, training: @training }
			end
			it 'updateしてuser/showページにリダイレクトすること' do
				expect(response).to redirect_to user_path(id: 1)
			end
			it 'データベースが更新されること' do
				expect(Training.first.goal).to eq 1
			end
		end
		context '無効なパラメータの場合' do
			before do
				@invalid_training = attributes_for(:invalid_training)
				patch :update, params:{ user_id: 1, training: @invalid_training}
			end
			it 'edit.jsにrenderすること' do
				expect(response).to render_template 'edit.js'
			end
			it 'データベースに登録されないこと' do
				expect(Training.first.progress).to eq 3
			end
		end
	end
end
