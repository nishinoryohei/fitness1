class CartItem < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	belongs_to :user
	belongs_to :item
	def self.current_cart_in_item_id user_id
		where(is_purchase: true, user_id: user_id).map(&:item_id)
	end
end
