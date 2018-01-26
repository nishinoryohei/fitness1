module UsersHelper
	def user_item_total_fee user
		user.cart_items.map {|f| 
			if f.is_purchase == true
				f.item.price*f.quantity
			else
				nil.to_i
			end
		}.sum
	end 
	 # Item.joins(:category).merge(Category.where(genre:[1,2,3]))
	def figure_color
		case @user.status
			when 6
				'red'
			when 4 || 5
				'orange'
			when 1 || 3
				'yellow'
			when 2
				'green'							
		end		
	end
	def figure
		case @user.status 
 			when 1 
				'too skinny'
 			when 2 
				'standard'
 			when 3 
				'a little fat'
 			when 4 
				'overweight'
 			when 5 
				 'fat'
 			when 6 
				 'danger'
 		end 
 	end
 		def figure_jp
		case @user.status 
 			when 1 
				'痩せています、瘦せすぎもあまりよくありません'
 			when 2 
				'標準レベル、この調子で頑張ってください'
 			when 3 
				'若干太り気味です、少し気を付けましょう'
 			when 4 
				'太っています、運動しましょう'
 			when 5 
				'太っています、食事制限をしましょう'
 			when 6 
				'太りすぎです、危険な状態です'
 		end 
 	end
 	def recommended_items
 		case @user.status
 			when 1
 				genres = [21,12,24]
 			when 2
 				genres = [11,41,22,32]
 			when 3
 				genres = [31,42,44]
 			when 4
 				genres = [31,42,44]
 			when 5
 				genres = [31,42,44]
		end
		Item.joins(:category).merge(Category.where(genre:genres))
	end
	def lifestyle_color
		@user.bodies.empty? ? '' : case @user.bodies.first.score	 
			when 0..2
				'red'
			when 3..5
				'orange'
			when 6..7
				'yellow'
			when 8..9
				'green'							
		end		
	end
 	def lifestyle
		@user.bodies.empty? ? '' : case @user.bodies.first.score	
 			when 0..2 
				'bad'
 			when 3..5 
				'a bit bad'
 			when 6..7 
				'good'
 			when 8..9 
				'perfect'
 		end
 	end 
 	def lifestyle_jp
		@user.bodies.empty? ? '' : case @user.bodies.first.score	
 			when 0..2 
				'生活習慣が悪いです'
 			when 3..5 
				'自分の生活を少し見直してみましょう'
 			when 6..7 
				'生活習慣はいい感じです'
 			when 8..9
				'パーフェクト、この調子で維持しましょう'
 		end
 	end 
 		def weight_chart
		line_chart [
			{ data: @weight_chart},
		],legend: false,height:"250px"
	end
end
