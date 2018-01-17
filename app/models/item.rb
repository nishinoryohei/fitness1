class Item < ApplicationRecord
	validates :name, presence: true
	validates :description, presence: true
	validates :price, presence: true
	default_scope -> {order(created_at: :desc)}
	belongs_to :user
	has_one :category, dependent: :delete
	has_many :thumbnailes, dependent: :destroy
	has_many :cart_items
	# scope :join_category, -> {joins(:category)}
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
