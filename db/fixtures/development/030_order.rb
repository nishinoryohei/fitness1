3000.times do |i|
	Order.seed(:id) do |o|
		o.id = i + 1
		o.user_id = rand(5..100)
		o.total_fee = [10000, 20000, 30000, 40000,].sample
		o.payment_status = [true, false].sample
	end
end
