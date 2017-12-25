FactoryBot.define do
  factory :body, class: Body do
  	weight  70.0
  	height  170.0
  	bmi  24.0
  	score  5
  	user_id  1
  end

  factory :invalid_body, class: Body do
  	weight  nil
  	height  '1'
  	bmi  24.0
  	score  nil
  	user_id  1
  end
end