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
        enrolled_year: DateTime.now.strftime("%Y").to_i,
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

  describe '#enrolled_year' do
    context '規定の年より少ない場合' do
      it 'バリデーションエラーを出す' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          enrolled_year: 1999
          )
        expect(profile).not_to be_valid
      end
    end
    context '規定の年より多い場合' do
      it 'バリデーションエラーを出す' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          enrolled_year: DateTime.now.strftime("%Y").to_i + 1
        )
        expect(profile).not_to be_valid
      end
    end
    context '規定の年の場合' do
      it '正常に保存される' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          enrolled_year: DateTime.now.strftime("%Y").to_i
        )
        expect(profile).to be_valid
      end
    end
  end


  describe '#twitter_id' do
    context '日本語が使われている場合' do
      it 'バリデーションエラーを出す' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          twitter_id: 'てすと',
          enrolled_year: DateTime.now.strftime("%Y").to_i
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
          enrolled_year: DateTime.now.strftime("%Y").to_i
        )
        expect(profile).not_to be_valid
      end
    end
  end

  describe '#instagram_id' do
    context '30文字以上の場合' do
      it 'バリデーションエラーを出す' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          instagram_id: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          enrolled_year: DateTime.now.strftime("%Y").to_i
        )
        expect(profile).not_to be_valid
      end
    end

    context '日本語が含まれている場合' do
      it 'バリデーションエラーを出す' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          instagram_id: 'テスト',
          enrolled_year: DateTime.now.strftime("%Y").to_i
        )
        expect(profile).not_to be_valid
      end
    end

    context 'インスタグラムのidのフォーマットに適合する場合' do
      it '正常に保存される' do
        profile = Profile.new(
          id: 1,
          user: User.new(id: 1),
          instagram_id: 'test123',
          enrolled_year: DateTime.now.strftime("%Y").to_i
        )
        expect(profile).to be_valid
      end
    end

  end

end
