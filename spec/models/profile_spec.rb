require 'rails_helper'

RSpec.describe Profile, type: :model do

  context 'すべてのparameterが揃っている場合' do
    it '正常に保存される' do
      expect(build(:profile)).to be_valid
    end
  end

  describe '#school_class' do
    context '3文字を超える場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.school_class = 123
        expect(profile).not_to be_valid
      end
    end

    context 'ブランクの場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.school_class = ''
        expect(profile).not_to be_valid
      end
    end
  end

  describe '#number' do
    context '3文字を超える場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.number = 123
        expect(profile).not_to be_valid
      end
    end

    context 'ブランクの場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.number = ''
        expect(profile).not_to be_valid
      end
    end
  end

  describe '#student_id' do
    context '7文字を超える場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.student_id = '12345678'
        expect(profile).not_to be_valid
      end
    end

    context '7文字未満の場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.student_id = '123456'
        expect(profile).not_to be_valid
      end
    end

    context 'ブランクの場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.student_id = ''
        expect(profile).not_to be_valid
      end
    end
  end

  describe '#enrolled_year' do
    context '規定の年未満の場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.enrolled_year = 1999
        expect(profile).not_to be_valid
      end
    end

    context '規定の年を超える場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.enrolled_year = DateTime.now.strftime('%Y').to_i + 1
        expect(profile).not_to be_valid
      end
    end
  end

  describe '#twitter_id' do
    context '含まれてはいけない文字がある場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.twitter_id = 'てすと'
        expect(profile).not_to be_valid
      end
    end

    context '15文字を超える場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.twitter_id = '1234567890123456'
        expect(profile).not_to be_valid
      end
    end

    context 'ブランクの場合' do
      it '正常に保存される' do
        profile = build(:profile)
        profile.twitter_id = ''
        expect(profile).to be_valid
      end
    end
  end

  describe '#instagram_id' do
    context '30文字を超える場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.instagram_id = '1234567890123456789012345678901'
        expect(profile).not_to be_valid
      end
    end

    context '含まれてはいけない文字がある場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.instagram_id = 'テスト'
        expect(profile).not_to be_valid
      end
    end

    context 'ブランクの場合' do
      it '正常に保存される' do
        profile = build(:profile)
        profile.instagram_id = ''
        expect(profile).to be_valid
      end
    end
  end

  describe '#discord_name' do
    context '名前が32文字を超える場合' do
      it 'バリデーションエラーが出る' do
        profile = build(:profile)
        profile.discord_name = '123456789012345678901234567890123'
        expect(profile).not_to be_valid
      end
    end

    context 'ブランクの場合' do
      it '正常に保存される' do
        profile = build(:profile)
        profile.discord_name = ''
        expect(profile).to be_valid
      end
    end
  end

  describe '#discord_tag' do
    context '0から始まる場合' do
      it 'エラーを出す' do
        profile = build(:profile)
        profile.discord_tag = '0012'
        expect(profile).not_to be_valid
      end
    end

    context 'ブランクの場合' do
      it '正常に保存される' do
        profile = build(:profile)
        profile.discord_tag = ''
        expect(profile).to be_valid
      end
    end

    context '4文字以内の場合' do
      it '正常に保存される' do
        profile = build(:profile)
        profile.discord_tag = '12'
        expect(profile).to be_valid
      end
    end

    context '4文字を超える場合' do
      it 'エラーが出る' do
        profile = build(:profile)
        profile.discord_tag = '12345'
        expect(profile).not_to be_valid
      end
    end
  end

end
