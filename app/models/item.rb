class Item < ApplicationRecord
	default_scope -> {order(created_at: :desc)}
	belongs_to :user
	validates :name, presence: true
	validates :description, presence: true
	validates :price, presence: true,numericality: {only_integer: true, greater_than: 0 }
	validates :stock, presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 0 }
	has_one :category, dependent: :delete
	has_many :thumbnails, dependent: :destroy
	has_many :cart_items
	has_many :reviews
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
	scope :soldout_items, ->(boolean){
		unless boolean.nil?
			if boolean == '1'
				where(Item.arel_table[:stock].eq(0))
			end
		end
	}
end
