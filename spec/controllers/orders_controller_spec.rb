require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
	let(:user) { User.find(1) }
	before do
		login_user user
	end
	describe 'POST#create' do
		context '有効なパラメータの場合' do
			before do
				@order = attributes_for(:order)
				post :create, params:{ order: @order }
			end
			it 'リクエストが302になること' do
				expect(response.status).to eq 302
			end
			it 'root_pathへリダイレクトすること' do
				expect(response).to redirect_to root_path
			end
			it 'データベースに登録されること' do
				expect{
					post :create, params:{ order: @order }
				}.to change(Order, :count).by(1)
			end
		end
		context '無効なパラメータの場合' do
			before do
				@invalid_order = attributes_for(:invalid_order)
				post :create, params:{ invalid_order: @invalid_order }
			end
			it 'リクエストが302になること' do
				expect(response.status).to eq 302
			end
			it 'root_pathへリダイレクトすること' do
				expect(response).to redirect_to root_path
			end
		end
	end
	describe 'PATCH#update' do
		let(:order) { create(:order) }
		before do
			patch :update, params:{ order: attributes_for(:order, payment_status: true), id: order.id }
		end
		it 'リクエストが302になること' do
			expect(response.status).to eq 302
		end
		it 'root_pathへリダイレクトすること' do
			expect(response).to redirect_to orders_path
		end
		it 'データベースが更新されること' do
			order.reload
			expect(order.payment_status).to eq true
		end
	end
end
