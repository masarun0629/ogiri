FactoryBot.define do
  factory :answer do
    answer      {"担任がチンパンジー"}
    association :user
    association :question
  end
end
