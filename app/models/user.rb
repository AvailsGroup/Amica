class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, password_length: 8...128

  has_one :profile
  before_create :build_default_profile

  private
  def build_default_profile
    build_profile
    true
  end

end
