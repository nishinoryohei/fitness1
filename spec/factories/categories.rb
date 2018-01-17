FactoryBot.define do
  factory :category, class: Category do
  	item_id 1
    genre 'food'
    keyword 'test'
  end
  factory :invalid_category, class: Category do
  	item_id 1
  	genre nil
  	keyword 123
  end
end
