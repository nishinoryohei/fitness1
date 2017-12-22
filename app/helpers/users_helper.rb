module UsersHelper
	def once_a_day? user
		user.last.created_at.tomorrow.day <= Date.today.day
	end
end
