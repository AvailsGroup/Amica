class User < ApplicationRecord
  include Discard::Model

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, password_length: 8...24

  acts_as_taggable
  acts_as_taggable_on :accreditations

  has_one_attached :image

  has_one_attached :header

  before_create :build_default_profile

  validate :validate_tag

  validate :image_size

  validate :header_size

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{8,24}+\z/ }, allow_nil: true

  validates :agreement_terms, allow_nil: false, acceptance: true, on: :create

  validates :email,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[A-Za-z0-9]+@gn.iwasaki.ac.jp\z/ }

  validates :name,
            length: { minimum: 2, maximum: 20 },
            allow_nil: true

  validates :nickname,
            length: { minimum: 2, maximum: 20 },
            allow_nil: true

  validates :userid,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[A-Za-z][A-Za-z0-9_]*\z/ },
            length: { minimum: 1, maximum: 20 },
            allow_nil: true

  validates :userid,
            uniqueness: { case_sensitive: false },
            format: { without: /\Afollow\z/i },
            length: { minimum: 1, maximum: 20 },
            allow_nil: true


  validates :userid,
            uniqueness: { case_sensitive: false },
            format: { without: /\Afollower\z/i },
            length: { minimum: 1, maximum: 20 },
            allow_nil: true


  validates :userid,
            uniqueness: { case_sensitive: false },
            format: { without: /\Afriends\z/i },
            length: { minimum: 1, maximum: 20 },
            allow_nil: true


  validates :userid,
            uniqueness: { case_sensitive: false },
            format: { without: /\Apickup\z/i },
            length: { minimum: 1, maximum: 20 },
            allow_nil: true

  has_one :profile
  accepts_nested_attributes_for :profile, update_only: true

  has_one :setting

  has_many :posts, dependent: :destroy
  has_many :likes

  has_many :community_securities

  has_many :comments, dependent: :destroy

  has_one :favorite

  has_one :achievement, dependent: :destroy

  # フォローしている側のユーザー (active relationship)
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed

  # フォローされている側のユーザー(passive relationship)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :communities, dependent: :destroy
  has_many :community_member, dependent: :destroy
  has_many :community_messages, dependent: :destroy

  has_many :reports

  has_many :passive_reports, class_name: "Report", foreign_key: "reported_user_id"
  has_many :reported_users, through: :passive_reports, source: :reported_user

  has_many :rooms
  has_many :messages

  # 通知を送るユーザー
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 通知をうけるユーザー
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_many :mutes

  has_many :blocks
  has_many :passive_blocks, class_name: "Block", foreign_key: "blocked_user_id", dependent: :destroy

  has_many :information_shows

  has_many :whispers

  has_many :active_favorites, class_name: 'Favorite', foreign_key: 'user_id', dependent: :destroy
  has_many :passive_favorites, class_name: 'Favorite', foreign_key: 'favorite_user_id', dependent: :destroy

  def password_required?
    super && confirmed?
  end

  def active_for_authentication?
    super && confirmed? && !discarded?
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

  def active?
    !ban?
  end

  def liked_by?(post_id)
    likes.any? { |p| p.post_id == post_id }
  end

  private

  def build_default_profile
    build_profile
    true
  end

  def validate_tag
    return if tag_list == nil?

    tag_list.each do |tag|
      errors.add(:tag_list, 'は1つ2~20文字です。') if (tag.length < 2) || (tag.length > 20)
      errors.add(:tag_list, "には記号やスペースを入れることが出来ません [#{tag}]") unless /\A[a-zA-Z0-9ぁ-んァ-ヶ一-龥々ー]+\z/u.match?(tag)
    end
  end

  def image_size
    return unless image.attached?

    if image.blob.byte_size > 10.megabytes
      image.purge
      errors.add(:image, "は10MB以内にしてください")
    end
  end

  def header_size
    return unless header.attached?

    if header.blob.byte_size > 10.megabytes
      header.purge
      errors.add(:image, "は10MB以内にしてください")
    end
  end
end
