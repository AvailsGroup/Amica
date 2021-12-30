class Like < ApplicationRecord
    # 以下の2行を追記
    belongs_to :user
    belongs_to :post

    validates :user, uniqueness: { scope: :post }
end
