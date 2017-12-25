module ApplicationHelper
	def once_a_day? user
		user.empty? || user.last.created_at.tomorrow.day <= Date.today.day
	end
end
