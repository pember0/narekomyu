class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # バリデーション設定
  validates :comment,presence: { message: "は必須です" }               # コメント

end
