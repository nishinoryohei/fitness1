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
	describe 'GET#show' do
		context 'トレーナー' do
			let(:item) { create(:item) }
			let(:cart_item) { create(:cart_item) }
			before do
				login_user trainer
				get :show, params:{ id: item }
			end
			it 'リクエストが200になること' do
				expect(response.status).to eq 200
			end
		end
		context '一般ユーザー' do
			before do
				login_user user
			end
			context '在庫のある商品' do
				let(:item) { create(:item) }
				before do
					get :show, params: { id: item }
				end
				it 'リクエストが200になること' do
					expect(response.status).to eq 200
				end
				it '@cart_itemにパラメータを割り当てること' do
					expect(assigns(:cart_item)).to be_a_new(CartItem)
				end
				it '@reviewにパラメータを割り当てること' do
					expect(assigns(:review)).to be_a_new(Review)
				end
			end
			context '売り切れの商品' do
				let(:sold_out_item) { create(:sold_out_item) }
				it 'items_pathへリダイレクトすること' do
					get :show, params: { id: sold_out_item }
					expect(response).to redirect_to items_path
				end
			end
		end
	end
	describe 'PATCH#update' do
		context 'トレーナー' do
			let(:item) { create(:item) }
			before do
				login_user trainer
			end
			context '有効なパラメータの場合' do
				before do
					patch :update, params:{
					 item: attributes_for(:item, name: 'test'), id:item
					}
				end
				it 'items_pathへリダイレクトすること' do
					expect(response).to redirect_to item_path(item)
				end
				it 'データベースが更新されること' do
					item.reload
					expect(item.name).to eq 'test'
				end
			end
			context '無効なパラメータの場合' do
				before do
					patch :update, params:{
						item: attributes_for(:invalid_item),id:item
					}
				end
				it 'items_pathへリダイレクトすること' do
					expect(response).to redirect_to item_path(item)
				end
				it 'データベースが更新されないこと' do
					item.reload
					expect(item).not_to eq :invalid_item
				end
			end
		end
	end
end
