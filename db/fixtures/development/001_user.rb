100.times do |i|
	User.seed(:id) do |user|
		user.id = i + 1
		user.name = "#{i + 1}号"
		user.status = rand(1..6)
		user.email = "hoge#{i + 1}@test"
		user.password = i + 100000
		user.trainer = false
	end
end
