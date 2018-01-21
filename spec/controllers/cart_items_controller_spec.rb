require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
	let(:user) { User.find(1) }
	before do
		login_user user
	end
	describe 'POST#create' do
		let(:item) { Item.find(1) }
		context '有効なパラメータの場合' do
			before do
				@cart_item = attributes_for(:cart_item)
				post :create, params:{ cart_item: @cart_item, item_id: item.id }
			end
			it 'リクエストが302になること' do
				expect(response.status).to eq 302
			end
			it 'saveしてroot_pathにリダイレクトすること' do
				expect(response).to redirect_to root_path
			end
			it 'データベースに登録されること' do
				expect{
					post :create, params:{ cart_item: @cart_item, item_id: item.id }
				}.to change(CartItem, :count).by(1)
			end
		end
		context '無効なパラメータの場合' do
			before do
				@invalid_cart_item = attributes_for(:invalid_cart_item)
				post :create, params:{ cart_item: @invalid_cart_item, item_id: item.id }
			end
			it 'リクエストが302になること' do
				expect(response.status).to eq 302
			end
			it 'item_pathへリダイレクトすること' do
				expect(response).to redirect_to item_path(item.id)
			end
			it 'データベースに登録されないこと' do
				expect{
					post :create, params:{ cart_item: @invalid_cart_item, item_id: item.id }
				}.not_to change(CartItem, :count)
			end
		end
	end
	describe 'DELETE#destroy' do
		let(:cart_item) { create(:cart_item) }
		before do
			delete :destroy, params:{ item_id: 1 }
		end
		it 'リクエストが302になること' do
			expect(response.status).to eq 302
		end
		it 'root_pathにリダイレクトすること' do
			expect(response).to redirect_to root_path
		end
	end
end
