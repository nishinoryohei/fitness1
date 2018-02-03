class Review < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	belongs_to :item
	belongs_to :user
	validates :score, presence: true
	validates :content, presence: true
end

