require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
	let(:user) { User.find(1)}
	let(:trainer) { User.find(2)}
	describe 'GET#new' do
		context 'トレーナー' do
			before do
				login_user trainer
				get :new
			end
			it 'リクエストが200になること' do
				expect(response.status).to eq 200
			end
			it '@itemにパラメータを割り当てること' do
				expect(assigns(:item)).to be_a_new(Item)
			end
		end
		context '一般ユーザー' do
			before do
				login_user user
				get :new
			end
			it 'パラメータが302になること' do
				expect(response.status).to eq 302
			end
			it 'items_pathへリダイレクトする' do
				expect(response).to redirect_to items_path
			end
		end
	end
	describe 'POST#create' do
		context 'トレーナー' do
			before do
				login_user trainer
			end
			context '有効なパラメータの場合' do
				before do 
					@item = attributes_for(:item)
					post :create, params:{ item: @item },xhr: true
				end
				render_views
				it 'リクエストが200になること' do
					expect(response.status).to eq 200
				end
				it 'create.jsを読み込むこと' do
					expect(response).to render_template :create
				end
				it '_form.htmlを表示すること' do
					expect(response).to render_template(partial: '_form')
				end
				it 'データベースに登録されること' do
					expect{
						post :create, params:{ item: @item },xhr: true
					}.to change(Item, :count).by(1)
				end
			end
			context '無効なパラメータの場合' do
				before do
					@invalid_item = attributes_for(:invalid_item)
					post :create, params:{ item: @invalid_item },xhr: true
				end
				it 'データベースに登録されないこと' do
					expect{
						post :create, params:{ item: @invalid_item }
					}.not_to change(Item, :count)
				end
			end
		end
		context '一般ユーザー' do
			before do
				login_user user
			get :new
			end
			it 'リクエストが302になること' do
				expect(response.status).to eq 302
			end
			it 'items_pathへリダイレクトする' do
				expect(response).to redirect_to items_path
			end
		end
	end
	describe 'GET#index' do
		before do
			login_user user
			get :index
		end
		it 'リクエストが200になること' do
			expect(response.status).to eq 200
		end
		it 'index.htmlを表示すること' do
			expect(response).to render_template :index
		end
	end
end
