require 'rails_helper'

RSpec.describe PersonalsController, type: :controller do
	let(:user) { User.find(1) }
	before do
		login_user user
	end
	describe 'GET#new' do
		before do
			get :new
		end
		it 'リクエストが200になること' do
			expect(response.status).to eq 200
		end
		it '@personalにパラメータを割り当てること' do
			expect(assigns(:personal)).to be_a_new(Personal)
		end
	end
	describe 'POST#create' do
		context '有効なパラメータの場合' do
			before do
				@personal = attributes_for(:personal)
				post :create, params:{ personal: @personal }
			end
			it 'saveしてnew_personal_pathへリダイレクトすること' do
				expect(response).to redirect_to new_personal_path
			end
			it 'データベースに登録されること' do
				expect{
					post :create, params:{ personal: @personal }
				}.to change(Personal, :count).by(1)
			end
		end
		context '無効なパラメータの場合' do
			before do
				@invalid_personal = attributes_for(:invalid_personal)
				post :create, params:{ personal: @invalid_personal }
			end
			it 'new_personal_pathへリダイレクトすること' do
				expect(response).to redirect_to new_personal_path
			end
			it 'データベースに登録されないこと' do
				expect{
					post :create, params:{ personal: @invalid_personal } 
				}.not_to change(Personal, :count)
			end
		end
	end
	describe 'GET#edit' do
	 	let(:personal) { create(:personal) }
	 	before do
	 		get :edit, params:{ id: personal }
	 	end
	 	it 'リクエストが200になること' do
	 		expect(response.status).to eq 200
	 	end
	end
	describe 'PATCH#update' do
		let(:personal) { create(:personal) }
		context '有効なパラメータの場合' do
			before do
				patch :update, params:{ 
					personal: attributes_for(:personal, state: 2), id: personal
				}
			end
			it 'new_personal_pathへリダイレクトすること' do
				expect(response).to redirect_to new_personal_path
			end
			it 'データベースが更新されること' do
				personal.reload
				expect(personal.state).to eq 2
			end
		end
		context '無効なパラメータの場合' do
			before do
				patch :update, params:{ 
					personal: attributes_for(:invalid_personal),id: personal
				}
			end
			it 'new_personal_pathへリダイレクトすること' do
				expect(response).to redirect_to new_personal_path
			end
			it 'データベースが更新されないこと' do
				personal.reload
				expect(personal).not_to eq :invalid_personal
			end
		end
	end
end
