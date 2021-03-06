class Training < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	belongs_to :user
	validates :goal, presence: true
	validates :progress, numericality: true
	#---グラフのパラメータ---
	def self.chart_goal user_id
		array = select(:created_at, :goal).where(user_id: user_id).limit(8).map{
			|i| [ i[:created_at].strftime('%m月%d日'),i[:goal] ]
		}	
	end
	def self.chart_progress user_id
		array = select(:created_at, :progress).where(user_id: user_id).limit(8).map{
			|i| [ i[:created_at].strftime('%m月%d日'),i[:progress] ]
		}
	end
end
		# array = select(:created_at, :progress).where(user_id: user_id).limit(8).map{
		# 	|i| [ i[:created_at].strftime('%m月%d日'),i[:progress] ]
		# }
