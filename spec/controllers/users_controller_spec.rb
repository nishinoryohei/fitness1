require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	let(:user) { User.find(1) }
	let(:trainer) { User.find(2) }
	render_views
	describe 'GET#show' do
		context '一般ユーザー' do
			before do
				login_user user
				get :show, params:{ id: 1 }
			end
			it 'リクエストが200になること' do
				expect(response.status).to eq 200
			end
			it '_trainer.htmlが表示されないこと' do
				expect(response).not_to render_template(partial: '_trainer')
			end
		end 
		context 'トレーナー' do
			before do
				login_user trainer
				get :show, params:{ id: 2 }
			end
			it 'リクエストが200になること' do
				expect(response.status).to eq 200
			end
			it '_trainer.htmlが表示される' do
				expect(response).to render_template(partial: '_trainer')
			end
		end
	end
	describe 'GET#inbox' do
		before do
			login_user user
			get :inbox, params:{ id: 1 }
		end
		render_views
		it 'リクエストが200になること' do
			expect(response.status).to eq 200
		end
		it 'inbox.htmlが表示されること' do
			expect(response).to render_template(:inbox)
		end
	end
	describe 'GET#inbox_show' do
		before do
			login_user user
			get :inbox_show, params:{ id:1 }, xhr: true
		end
		it 'リクエストが200になること' do
			expect(response.status).to eq 200
		end
		it '_talk-room.htmlが表示されること' do
			expect(response).to render_template(partial: '_talk-room')
		end
	end
end
