require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
	let(:user) { User.find(1) }
	let(:trainer) { User.find(2) }
	describe 'POST#create' do
		context 'トレーナー' do
			before do
				login_user trainer
			end
			render_views
			context '有効なパラメータの場合' do
				before do 
					@category = attributes_for(:category)
					post :create, params:{ category: @category },xhr: true
				end
				it 'リクエストが200になること' do
					expect(response.status).to eq 200
				end
				it 'create.jsを読み込むこと' do
					expect(response).to render_template :create
				end
				it '_form.htmlをひょうじすること' do
					expect(response).to render_template(partial: '_form')
				end
				it 'データベースに登録されること' do
					expect{
						post :create, params:{ category: @category },xhr: true
					}.to change(Category, :count).by(1)
				end
			end
			context '無効なパラメータの場合' do
				let(:item) { create(:item) }
				before do 
					@item = item
					@invalid_category = attributes_for(:invalid_category)
					post :create,params:{ category: @invalid_category }
				end
				it 'new_item_pathにリダイレクトすること' do
					expect(response).to redirect_to new_item_path
				end
				it 'データベースに登録されないこと' do
					expect{
						post :create, params:{ category: @invalid_category },xhr: true
					}.not_to change(Category, :count)
				end
			end
		end
		context '一般ユーザー' do
		  	before do
		  		login_user user
		  		@category = attributes_for(:category)
				post :create, params:{ category: @category }
		  	end
		 	it 'パラメータが302になること' do
		  		expect(response.status).to eq 302
		  	end
		  	it 'items_pathへリダイレクトすること' do
		  		expect(response).to redirect_to items_path
		  	end
		end
	end
end
