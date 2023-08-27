# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者のダミーアカウントを生成
users= [
#{ name: 'sample3', email: 'sample3@example.com', password: '000000' },
#{ name: 'sample4', email: 'sample4@example.com', password: '000000' },
#{ name: '管理者', email: 'admin@example.com', password: '000000', introduction: '管理者アカウント', is_administrator: true }
#{ name: 'admin', email: 'admin1@example.com', password: '000000', introduction: '管理者アカウント', is_administrator: true }
]
users.each do |record|
 User.create!(record) unless User.find_by(email: record[:email])
end

#タグの登録
tags= [
#{ tag_name: 'code' },
#{ tag_name: 'SQL' },
#{ tag_name: 'DB' },
#{ tag_name: 'Git Hub' },
#{ tag_name: 'HTML・CSS' },
#{ tag_name: 'その他' },
]
tags.each do |record|
 Tag.create!(record) unless Tag.find_by(tag_name: record[:tag_name])
end