 100.times do |i|
	Personal.seed(:id) do |p|
		p.id = i + 1
		p.user_id = i + 1
		p.state = rand(1..47)
		p.city = "#{i + 1}番市"
		p.address = "#{i + 1}丁目１番地"
		p.tel = "123-4567-8#{i}"
	end
end
