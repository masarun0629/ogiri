FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number:10)}
    profile               {Faker::Lorem.sentence}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end
