class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      # t.データ型 :カラム
      # タグ名
      t.string :tag_name,               null: false

      t.timestamps
    end
  end
end
