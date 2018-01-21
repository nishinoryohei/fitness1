FactoryBot.define do
  factory :cart_item, class: CartItem do
    item_id 1
    user_id 1
    quantity 1
    is_purchase false
  end
  factory :invalid_cart_item, class: CartItem do
  	item_id 1
  	user_id 1
  	quantity nil
  	is_purchase false
  end
end
