1000.times do |i|
	Comment.seed(:id) do |c|
		c.id = i + 1
		c.receiver_id = rand(1..10)
        c.server_id = rand(1..10)
        c.content = 'testtesttesttesttesttesttesttest'
	end
end
