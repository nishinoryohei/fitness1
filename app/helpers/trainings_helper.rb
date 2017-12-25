module TrainingsHelper
	def training_reported? user
		user.trainings.empty? || user.trainings.last.created_at != user.trainings.last.updated_at
	end
	def training_chart
		line_chart [
			{ name: '目標', data: @goal_chart},
			{ name: '結果', data: @progress_chart}
		]
	end
	def training_evaluation
		if @user.trainings[-2].fruition == false
			'失敗'
		else
			'目標達成！'
		end
	end
end
