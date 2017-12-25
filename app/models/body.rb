class Body < ApplicationRecord
	belongs_to :user
	validates :weight, presence: true
	validates :height, presence: true
end
