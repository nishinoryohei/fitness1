class Category < ApplicationRecord
	validates :genre, presence: true
	belongs_to :item, dependent: :delete
	validates :genre, presence: true
	enum genre:{
	 	food: 1, supplement:11, protein:21, diet:31, drink:41,
	 	equipment:2,muscle:12, beauty:22, health:32, life: 42,
	 	clothes:3,female: 13, man: 23, children: 33, big: 43,
	 	other:4,ticket: 14, service: 24, guidance: 34, gym: 44
	}
	scope :genre_search, ->(genre){
		unless nil?
			where("'categories'.'genre' REGEXP ?", genre.to_s + '$')
		end
	}
end