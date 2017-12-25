class Training < ApplicationRecord
	belongs_to :user
	validates :progress, presence: true
	validates :goal, presence: true
	def self.chart_goal user_id
		array = select(:created_at, :goal).where(user_id: user_id).collect{
			|i| [ i[:created_at].strftime('%m月%d日'),i[:goal] ]
		}	
	end
	def self.chart_progress user_id
		array = select(:created_at, :progress).where(user_id: user_id).collect{
			|i| [ i[:created_at].strftime('%m月%d日'),i[:progress] ]
		}	
	end
end
