class Message < ApplicationRecord
  has_many :room
  has_one_attached :file
  validates :user_id, :content, presence: true
    # createの後にコミットする { MessageBroadcastJobのperformを遅延実行 引数はself }
  after_create_commit { MessageBroadcastJob.perform_later self }


end
