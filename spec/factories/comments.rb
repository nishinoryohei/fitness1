FactoryBot.define do
  factory :comment, class: Comment do
    content "MyText"
    server_id 1
    receiver_id 2
  end

  factory :invalid_comment, class: Comment do
  	content nil
  end
end
