require 'rails_helper'

RSpec.describe Profile, type: :model do

  it 'is good validate' do
    profile = Profile.new(
      id: 1,
      user: User.new(id: 1),
      grade: 'テスト学科',
      school_class: 1,
      number: 10,
      enrolled_year: 2002,
      student_id: '1234567',
      intro: 'よろしくおねがいします',
      twitter_id: 'test',
      instagram_id: 'test',
      discord_name: 'test',
      discord_tag: '1234'
    )
    expect(profile).to be_valid
  end

  it 'is bad validate twitter_id' do
    profile = Profile.new(
      id: 1,
      user: User.new(id: 1),
      grade: 'テスト学科',
      school_class: 1,
      number: 10,
      enrolled_year: 2002,
      student_id: '1234567',
      intro: 'よろしくおねがいします',
      twitter_id: 'てすと',
      instagram_id: 'test',
      discord_name: 'test',
      discord_tag: '1234'
    )
    expect(profile).to be_valid
  end
end
