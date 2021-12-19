class Message < ApplicationRecord
  has_many :room
  validates :user_id, presence: true
    # createの後にコミットする { MessageBroadcastJobのperformを遅延実行 引数はself }
  after_create_commit { MessageBroadcastJob.perform_later self }


end
