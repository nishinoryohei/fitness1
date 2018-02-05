FactoryBot.define do
  factory :personal, class: Personal do
    tel "134-1234-1234"
    state 1
    city "MyString"
    address "MyString"
    user_id 1
  end
  factory :invalid_personal, class: Personal do
  	tel 12345678
  	state 1
  	city nil
  	address nil
  	user_id 1
  end
end
