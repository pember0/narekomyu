class Like < ApplicationRecord
  # Likeモデルのカラム（post_idとuser_id）は、Postモデル、Userモデルのidと関連付ける。
  belongs_to :user
  belongs_to :post
end
