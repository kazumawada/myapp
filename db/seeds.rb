# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "main-user",
    email: "main@gmail.com",
    year: "1年",
    bio: "hello!",
    password:              "password",
    password_confirmation: "password",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
name  = Faker::Name.name
email = "fake-#{n+1}@gggggggsdgmail.com"
password = "password"
User.create!(name:  name,
      email: email,
      year: "1年",
      bio: "hello!",
      password:              password,
      password_confirmation: password,
      activated: true,
      activated_at: Time.zone.now)


#6人のサンプル投稿
users = User.order(:created_at).take(6)
10.times do
  content = Faker::Lorem.sentence(word_count: 200)
  users.each { |user| user.posts.create!(content: content) }
end
end


#適当にrelationshipを作る。
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

