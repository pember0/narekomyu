class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーションを設定
  validates :name, uniqueness: true                 # 一意性を持たせる
  validates :name, length: { in: 2..20 }            # 2～20文字の範囲
  validates :introduction, length: { maximum: 50 }  #「50字以下」

  # # dependent: :destroyは、has_manyで使えるオプションです。 1:Nの関係において、
  # 「1」のデータが削除された場合、関連する「N」のデータも削除される設定
  has_many :posts, dependent: :destroy          # 投稿機能
  has_many :likes, dependent: :destroy          # いいね機能
  has_many :like_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy       # コメント機能

  # ActiveStorageでプロフィール画像を保存できるように設定
  has_one_attached :profile_image


  # ゲストユーザーのメールアドレス設定
  GUEST_USER_EMAIL = "guest@example.com"
  # ゲストユーザーのパスワード・nameの設定
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  # guest_user?メソッドを作成、メールアドレスがゲストユーザーのものであるかを判定しtrueかfalseの値を返します
  def guest_user?
    email == GUEST_USER_EMAIL
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    # メソッドに対して引数を設定し、引数に設定した値に画像のサイズを変換するように設定
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end
end
