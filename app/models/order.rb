class Order < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	belongs_to :user
	validates :user_id, presence: true
	validates :total_fee, presence: true
	scope :search_create_date, ->(date) {
		unless date.nil?
			where("Orders.created_at like'%"+date+"%'")
		end
	}
	scope :search_create_year, ->(date) {
		unless date.nil?
			where("Orders.created_at like'%"+date+"%'")
		end
	}
	scope :search_create_month, ->(date) {
		unless date.nil?
			where("Orders.created_at like'%"+date+"%'")
		end
	}
	scope :search_user_name, ->(user_name){
		unless user_name.nil?
			joins(:user).merge(User.where("name like'%"+user_name+"%'"))
		end
	}
	scope :search_state, ->(state){
		unless state.nil?
			joins(:user).merge(User.joins(:personal)).merge(Personal.where(state: state))
		end
	}
	scope :still_payment_orders, ->(payment_status){
		unless payment_status.nil?
			if payment_status == '1'
				where(payment_status: false)
			end
		end
	}
	# Order.where("created_at like '%31%'")
	# @still_payment_orders = Order.where(payment_status: false)
	# Order.joins(:user).merge(User.joins(:personal)).merge(Personal.where(user_id: 1))

end
