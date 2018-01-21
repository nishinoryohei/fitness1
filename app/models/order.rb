class Order < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	validates :user_id, presence: true
	validates :total_fee, presence: true
end
