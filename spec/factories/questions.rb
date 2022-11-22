FactoryBot.define do
  factory :question do
    question      {Faker::Lorem.sentence}
    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/LGTM.jpeg'), filename: 'LGTM.jpeg')
    end
  end
end
