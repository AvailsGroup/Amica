class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, password_length: 8...128

  has_many :favorite

  # アソシエーションの定義
  # フォローしている側のユーザー (active relationship)
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed

  # フォローされている側のユーザー(passive relationship)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

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


end
