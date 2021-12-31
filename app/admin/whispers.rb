ActiveAdmin.register Whisper do

  form do |f|
    panel '注意' do
      '文章が不適切でないかしっかり確認すること。'
    end
    f.inputs '新規送信' do
      f.input :user
      f.input :title
      f.input :content
    end
    f.actions
  end

  permit_params :user_id, :title, :content
end
