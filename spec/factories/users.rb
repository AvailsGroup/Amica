FactoryBot.define do
  factory :user do
    name { 'test' }
    sequence(:email) { |n| "test#{n}@gn.iwasaki.ac.jp" }
    password { '12345678' }
    confirmed_at { Date.today }
  end
end
