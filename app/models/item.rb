class Item < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	belongs_to :user
	has_one :category
	scope :join_category, -> {joins(:category)}
	scope :cheaper, -> (price){
		unless price.nil?
			where(Item.arel_table[:price].lteq(price))
		end
	}
	scope :expensive, -> (price){
		unless price.nil? 
			where(Item.arel_table[:price].gteq(price))
		end
	}
	scope :sort_by_genre, ->(genre){
		unless nil?
			joins(:category).merge(Category.genre_search(genre))
		end
	}
	scope :search_keyword, ->(keyword){
		unless keyword.nil?
			joins(:category).merge(Category.where("keyword like'%"+keyword+"%'"))
		end
	}
end
