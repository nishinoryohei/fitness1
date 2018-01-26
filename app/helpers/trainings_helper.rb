module TrainingsHelper
	def training_reported? user
		user.trainings.empty? || user.trainings.first.created_at != user.trainings.last.updated_at
	end
	def training_chart
		line_chart [
			{ name: '目標', data: @goal_chart},
			{ name: '結果', data: @progress_chart}
		] ,ytitle: "運動強度"
	end
	def training_evaluation
		if @user.trainings[2].nil? ||  @user.trainings[2].fruition == false
			'Failure'
		else
			'Attainment'
		end
	end
	def training_evaluation_jp
		if @user.trainings[2].nil? ||  @user.trainings[2].fruition == false
			'目標達成失敗、頑張りましょう'
		else
			'目標達成！この調子頑張ってください'
		end
	end
	def training_color
		if @user.trainings[2].nil? ||  @user.trainings[2].fruition == false
			'red'
		else
			'green'
		end
	end
	def proverb
		@@i = rand(1..3)
		case @@i
		when 1
			'It is hard to beat a person who never gives up.'
		when 2
			'Step by step. I can’t see any other way of accomplishing anything.'
		when 3
			'It’s lack of faith that makes people afraid of meeting challenges, and I believe in myself.
'
		end
	end
	def athlete
		case @@i
		when 1
			'George Herman Ruth'
		when 2
			'Michael Jeffrey Jordan'
		when 3
			'Muhammad Ali'
		end
	end
end
