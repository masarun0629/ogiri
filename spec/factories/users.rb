FactoryBot.define do
  factory :user do
    nickname              {"まさるん"}
    profile               {"よろしくお願いします"}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end
