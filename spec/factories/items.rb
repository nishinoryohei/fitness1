FactoryBot.define do
  factory :item, class: Item do
    name "MyString"
    description "MyText"
    price 1000
    stock 10
    user_id 2
  end
  factory :invalid_item, class: Item do
  	name nil
    description 123
    price '1000'
    stock nil
    user_id 2
  end
  factory :sold_out_item, class: Item do
    name "MyString"
    description "MyText"
    price 1000
    stock 0
    user_id 2
  end
end
