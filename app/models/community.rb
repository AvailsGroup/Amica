class Community < ApplicationRecord
  acts_as_taggable

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 20 },
            uniqueness: { case_sensitive: false }

  validates :content,
            length: { minimum: 0, maximum: 400 }

  validate :validate_tag

  has_many :community_members

  def validate_tag
    return if tag_list == nil?

    tag_list.each do |tag|
      errors.add(:tag_list, '1つのタグは2~20文字です。') if (tag.length < 2) || (tag.length > 20)
    end
  end
end
