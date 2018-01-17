class Category < ApplicationRecord
	validates :genre, presence: true
	belongs_to :item, dependent: :delete
	enum genre:{
		food: 1, equipment:2, clothes:3, other:4,
		supplement:11, protein:21, diet:31, drink:41,
		muscle:12, beauty:22, health:32, life: 42,
		female: 13, man: 23, children: 33, big: 43,
		ticket: 14, service: 24, guidance: 34, gym: 44
	}
	scope :genre_search, ->(genre){
		unless nil?
			where("'categories'.'genre' REGEXP ?", genre.to_s + '$')
		end
	}
end