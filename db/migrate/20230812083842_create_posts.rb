class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      # t.データ型 :カラム名
      # 会員ID
      t.integer :user_id,         null: false
      # タグID
      t.integer :tag_id,          null: false
      # タイトル
      t.string :title,            null: false
      # 質問内容
      t.text :question_content,   null: false

      t.timestamps
    end
  end
end
