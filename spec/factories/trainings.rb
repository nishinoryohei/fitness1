FactoryBot.define do
  factory :training, class: Training do
    progress 1
    goal 1
    fruition false
  end
  factory :invalid_training, class: Training do
  	progress nil
  	gole '1'
  	fruition false
  end
end
