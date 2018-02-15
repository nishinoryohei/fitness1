200.times do |i|
	Item.seed(:id) do |item|
		item.id = i + 1
		item.name = "#{i + 1}個目の商品名"
		item.description = "#{i + 1}番目の商品説明hogehogehogehogehogehogehogeohgehogehogehoge
		hogehogehogehogehogehoegehogehogeoheghogehogehogehogehogehogehogehogeohgehogeohgeohge
		hoehoeghogheogoehgoehgoehgoehgoehghoehgoehoghehoeghoehgoehgohgheoghogheohghhogehoge"
		item.price = [1000, 2000, 3000, 4000,5000,6000].sample
		item.user_id = rand(1..4)
		item.stock = rand(1..30)
	end
end
