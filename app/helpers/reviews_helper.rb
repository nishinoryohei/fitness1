module ReviewsHelper
	def score_average reviews
		scores = reviews.map(&:score)
		average = scores.inject(0.0){|r,i| r+=i}/scores.size
		if average.round(1).nan? 
			0
		else
			return average.round(1)
		end
	end
end
