FactoryBot.define do
  factory :question do
    question      {"こんな学校は嫌だ"}
    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/LGTM.jpeg'), filename: 'LGTM.jpeg')
    end
  end
end
