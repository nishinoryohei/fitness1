module UsersHelper
	def figure
		case @user.status 
 			when 1 
				'ガリガリだな'
 			when 2 
				'標準レベル、この調子で頑張って'
 			when 3 
				'若干太り気味'
 			when 4 
				'ぽっちゃり、軽くヤバい'
 			when 5 
				'デブです'
 			when 6 
				'養豚場送り'
 		end 
 	end
 	def lifestyle
		case @user.bodies.last.score
 			when 0..2 
				'生活習慣悪すぎ'
 			when 3..5 
				'自分の生活を少し見直してみましょう'
 			when 6..8 
				'生活習慣はいい感じです'
 			when 9 
				'パーフェクト、この調子で維持しましょう'
 		end
 	end 
end
