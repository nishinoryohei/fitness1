FactoryBot.define do
  factory :order,class: Order do
    user_id 1
    total_fee 1
    payment_status false
  end
  factory :invalid_order, class: Order do
    user_id 1
    total_fee 'valid'
    payment_status false
  end
end
