class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      # t.データ型 :カラム
      # 会員ID
      t.integer :user_id,         null: false
      # 投稿ID
      t.integer :post_id,         null: false

      t.timestamps
    end
  end
end
