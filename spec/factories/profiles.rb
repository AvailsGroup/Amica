FactoryBot.define do
  factory :profile do
    user { build(:user) }
    grade { 'テスト学科' }
    school_class { 1 }
    number { 10 }
    enrolled_year { DateTime.now.strftime('%Y').to_s }
    student_id { '1234567' }
    intro { 'よろしくおねがいします' }
    twitter_id { 'test' }
    instagram_id { 'test' }
    discord_name { 'test' }
    discord_tag { '1234' }
  end
end
