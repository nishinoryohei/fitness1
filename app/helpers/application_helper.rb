module ApplicationHelper
	def once_a_day? user
		user.empty? || user.last.created_at.tomorrow.to_date <= Date.today
	end
end
