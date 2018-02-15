200.times do |i|
	Category.seed(:id) do |c|
		c.id = i + 1
		c.item_id = i + 1
		c.genre = [1,2,3,4,11,21,31,41,12,22,32,42,13,23,33,43,14,24,34,44].sample
		c.keyword = ['hoge', 'test', 'fuga', 'あいうえお','筋トレ'].sample
	end
end