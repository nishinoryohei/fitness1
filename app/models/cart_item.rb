class CartItem < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	belongs_to :user
	belongs_to :item
	validates :item_id, presence: true
	validates :user_id, presence: true
	validates :quantity, presence: true
	validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
	def self.current_cart_in_item_id user_id
		where(is_purchase: true, user_id: user_id).map(&:item_id)
	end
end
