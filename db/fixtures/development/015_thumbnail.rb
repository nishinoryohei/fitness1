200.times do |i|
	Thumbnail.seed(:id) do |thumbnail|
		thumbnail.id = i + 1
		thumbnail.item_id = i + 1
		thumbnail.image = Rails.root.join('db/fixtures/images/kusuri.jpg').open
	end
end












