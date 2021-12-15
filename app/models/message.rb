class Message < ApplicationRecord
  has_many :room
  validates :content, presence: true, length: { maximum: 500 }
    # createの後にコミットする { MessageBroadcastJobのperformを遅延実行 引数はself }
  after_create_commit { MessageBroadcastJob.perform_later self }


end
