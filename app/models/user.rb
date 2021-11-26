class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, password_length: 8...24

  validates :password, format: { with: /\A[a-zA-Z0-9.$!@_%^*&()]{8,24}\z/ },allow_nil: true

  validates :agreement_terms, allow_nil: false, acceptance: true, on: :create

  validates :email,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[A-Za-z]{4}[0-9]{7}@gn.iwasaki.ac.jp\z/}
            #上記の正規表現は行頭から大小英語が4文字、数字が7文字、その後はドメインがそのとおりに入力されているかチェックようになっています

  validates :name,
            length: { minimum: 2, maximum: 20 },
            allow_nil: true

  validates :nickname,
            length: { minimum: 2, maximum: 20 },
            allow_nil: true

  validates :userid,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[A-Za-z][A-Za-z0-9_]*\z/},
            #上記の正規表現は行頭半角英語、それ以外は半角英数字が入力できるようになってます。
            length: { minimum: 1, maximum: 20 },
            allow_nil: true

  has_one :profile
  accepts_nested_attributes_for :profile, update_only: true

  # アソシエーションの定義
  # フォローしている側のユーザー (active relationship)
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed

  # フォローされている側のユーザー(passive relationship)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  def password_required?
    super && confirmed?
  end

  def active_for_authentication?
    super && confirmed?
  end

  def inactive_message
    confirmed? ? super : :needs_confirmation
  end

  # メソッドの定義
  # ユーザーをフォロー
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをアンフォロー
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 相手をフォローしていればtrueを返す
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def followers_list
    followers
  end

  def followings_list
    followings
  end

  # 友達（互いにフォローしている）をデータベースから取得
  def matchers
    followings & followers
  end

  # 相手と友達になっていればtrueを返す
  def matchers?(other_user)
    active_relationships.find_by(followed_id: other_user.id) && passive_relationships.find_by(follower_id: other_user.id)
  end

  # 自分はフォローしていない&相手からフォローされていればtrueを返す
  def follow_request?(user, other_user)
    !user.matchers?(other_user) && other_user.following?(user)
  end
  has_one :profile
  before_create :build_default_profile

  private
  def build_default_profile
    build_profile
    true
  end

  def active?
    !ban?
  end
end
