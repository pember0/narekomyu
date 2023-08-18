class Post < ApplicationRecord
  # 1:N の「N」側にあたるモデルに、belongs_to を記載
  belongs_to :user
  belongs_to :tag

  validates :title,presence:true                                  # タイトル
  validates :question_content,presence:true,length:{maximum:500}  # 質問内容

  # 1:N の「1」側にあたるモデルに、has_many を記載
  has_many :likes, dependent: :destroy                             # いいね機能
  has_many :comments, dependent: :destroy                          # コメント機能

  # 引数で渡されたユーザidがlikesテーブル内に存在（exists?）するかどうかを調べます。
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
