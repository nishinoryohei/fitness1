module ItemsHelper
	def sold_out? item
		item.stock == 0
	end
	def purchase_number item
		item.cart_items.map{|f| f.quantity}.sum
	end
	def subtotal item
		item.price * purchase_number(item)
	end
end
