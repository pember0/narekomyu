class Tag < ApplicationRecord
  # 1:N の「1」側にあたるモデルに、has_many を記載
  has_many :posts, dependent: :destroy                              # タグ
end
