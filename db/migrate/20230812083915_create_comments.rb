class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      # t.データ型 :カラム
      # 会員ID
      t.integer :user_id,         null: false
      # 投稿ID
      t.integer :post_id,         null: false
      # コメント
      t.text :comment,            null: false

      t.timestamps
    end
  end
end
