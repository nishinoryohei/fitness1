FactoryBot.define do
  factory :training, class: Training do
    progress 1
    goal 1
    fruition false
  end
  factory :invalid_training, class: Training do
  	progress 'test'
  	gole 'test'
  	fruition 'test'
  end
end
