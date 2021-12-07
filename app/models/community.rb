class Community < ApplicationRecord
  acts_as_taggable

  belongs_to :user

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 20 },
            uniqueness: { case_sensitive: false }

  validates :content,
            length: { minimum: 0, maximum: 400 }

  validate :validate_tag

  attr_accessor :image,:image_x,:image_y,:image_w,:image_h,:aspect_numerator,:aspect_denominator

  has_many :community_members, dependent: :destroy

  def validate_tag
    return if tag_list == nil?

    tag_list.each do |tag|
      errors.add(:tag_list, 'は1つ2~20文字です。') if (tag.length < 2) || (tag.length > 20)
      errors.add(:tag_list, "には記号やスペースを入れることが出来ません [#{tag}]") unless /\A[a-zA-Z0-9ぁ-んァ-ヶ一-龥々ー]+\z/u.match?(tag)
    end
  end
end
