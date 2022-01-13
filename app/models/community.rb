class Community < ApplicationRecord
  acts_as_taggable

  belongs_to :user

  has_one_attached :image

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 20 },
            format: { with: %r{\A[a-zA-Z0-9ぁ-んァ-ヶ一-龥々ー０-９!?~<>=_ 　]+\z}u },
            uniqueness: { case_sensitive: false }

  validate :validate_tag

  validate :image_size

  validate :content_length

  attr_accessor :image_x,:image_y,:image_w,:image_h,:aspect_numerator,:aspect_denominator

  has_many :community_members, dependent: :destroy

  has_many :community_securities, dependent: :destroy

  has_many :favorites

  has_many :reports

  has_many :community_messages

  has_many :favorites

  private

  def validate_tag
    return if tag_list == nil?

    tag_list.each do |tag|
      errors.add(:tag_list, 'は1つ2~20文字です。') if (tag.length < 2) || (tag.length > 20)
      errors.add(:tag_list, "には記号やスペースを入れることが出来ません [#{tag}]") unless /\A[a-zA-Z0-9ぁ-んァ-ヶ一-龥々ー]+\z/u.match?(tag)
    end
  end

  def content_length
    return if content == nil?

    content_for_validation = content.gsub(/\r\n/,"a")
    errors.add(:content, "は400文字以内で入力してください。") if content_for_validation.length > 400
  end

  def image_size
    return unless image.attached?

    if image.blob.byte_size > 10.megabytes
      image.purge
      errors.add(:image, "は10MB以内にしてください")
    end
  end
end
