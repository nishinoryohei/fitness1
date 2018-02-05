FactoryBot.define do
  factory :review, class: Review do 
    item_id 1
    user_id 1
    content "MyText"
    score 1
  end
  factory :invalid_review, class: Review do
  	item_id nil
  	user_id nil
  	content nil
  	score '1'
  end
end
