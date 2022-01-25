class Profile < ApplicationRecord
  belongs_to :user


  validates :school_class, format: { with: /\A[0-9]\z/ }
  validates :number, format: { with: /\A[0-9]{1,2}\z/ }
  validates :student_id, format: { with: /\A[0-9]{7}\z/ }
  validates :intro, length: { minimum: 0, maximum: 300 }, allow_nil: true
  validates :enrolled_year, format: { with: /\A[02][0-9]{3}\z/ }
  validates :twitter_id, format: { with: /\A[0-9a-zA-Z_]{1,15}\z/ }, length: { minimum: 0, maximum: 15 }, allow_nil: true, allow_blank: true
  validates :instagram_id, format: { with: /\A(?!\.)[\w.]+(?<!\.)\z/ }, length: { minimum: 0, maximum: 30 }, allow_nil: true, allow_blank: true
  validates :discord_name, length: { minimum: 0, maximum: 32 }, allow_nil: true, allow_blank: true
  validates :discord_tag, format: { with: /\A[0-9]{1,4}\z/ }, length: { minimum: 0, maximum: 4 }, allow_nil: true, allow_blank: true

  validate :can_register_enrolled_year

  private

  def can_register_enrolled_year
    return if enrolled_year.nil?

    if enrolled_year =~ /A[0-9]+z/
      errors.add(:enrolled_year, 'は不正な値です')
    end
    
    if enrolled_year == '0000'
      return
    end
    
    if enrolled_year.to_i < 2000 || enrolled_year.to_i > DateTime.now.strftime('%Y').to_i
      errors.add(:enrolled_year, 'は不正な値です')
    end
  end

end
