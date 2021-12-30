require 'rails_helper'

RSpec.describe Profile, type: :model do

  context 'すべてのparameterが揃っている場合' do
    it '正常に保存される' do
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
  end


  describe '#twitter_id' do
    context '日本語が使われている場合' do
      it 'バリデーションエラーを出す' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          twitter_id: 'てすと',
          enrolled_year: 2002,
        )
        expect(profile).not_to be_valid
      end
    end

    context '15文字以上の場合' do
      it 'バリデーションエラーを出す' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          twitter_id: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          enrolled_year: 2002,
        )
        expect(profile).not_to be_valid
      end
    end
  end

end
