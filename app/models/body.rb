class Body < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	belongs_to :user
	validates :weight, presence: true
	validates :height, presence: true
	def self.chart_weight user_id
		array = select(:created_at, :weight).where(user_id: user_id).limit(8).map{
			|i| [ i[:created_at].strftime('%m/%d'),i[:weight] ]
		}	
	end
end
