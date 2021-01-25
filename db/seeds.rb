# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name:  "main-user",
    email: "main@gmail.com",
    avatar: File.open(Rails.root.join('app', 'assets', 'images', 'the-main.jpg')),
    year: "1年",
    bio: "hello!",
    password:              "password",
    password_confirmation: "password",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

#簡単ログインのユーザー
User.create!(name: "簡単ログインしたユーザー",
  email: "smooth_login@example.com",
  avatar: File.open(Rails.root.join('app', 'assets', 'images', 'the-main.jpg')),
  year: "3年",
  bio: "hello!私はゲストユーザーです。",
  password:              "password",
  password_confirmation: "password",
  admin: false,
  activated: true,
  activated_at: Time.zone.now)



#そもそもtagない。schembaに。Postテーブルに。
  # Tag.create([
  #   { name: '移住' },
  #   { name: 'ワーキングホリデー' },
  #   { name: '食べ物'},
  #   { name: '転職'},
  #   { name: '街歩き'},
  #   { name: '生活'}
  #   ])

# postTagは、そもそもデータベースに入ってない。
# [6] pry(main)> PostTag.all
# =>   PostTag Load (2.5ms)  SELECT `post_tags`.* FROM `post_tags`
# []
# [7] pry(main)> PostTag.first
#   PostTag Load (3.0ms)  SELECT `post_tags`.* FROM `post_tags` ORDER BY `post_tags`.`id` ASC LIMIT 1
# => nil
# [8] pry(main)> PostTag[0]
# tagはどうやってpostから取ってくるか。でもDBに格納されてないんだよね.
# ここで定義して、post_idsの項目に突っ込む。
# でも、デバックでこう出てるからヒントになるかも
# --- !ruby/object:ActionController::Parameters
# parameters: !ruby/hash:ActiveSupport::HashWithIndifferentAccess
#########これ。##########################3
#   tag_id: '2'
######################################
#   controller: posts
#   action: index
# permitted: false
2.times do |n|
User.all.each do |user|
  user.posts.create!(
    title: 'jest jako przykładow',
    # tags: Tag.first,
    tag: "#移住",
    content: '#タグテスト Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed id justo tempus, congue erat ac, maximus lectus. Praesent pharetra rhoncus laoreet. Mauris ultricies ullamcorper arcu eu hendrerit. Nam a sem sed turpis tincidunt mattis. Vivamus maximus metus sit amet vestibulum pharetra. Vestibulum in lacinia elit, in tempor ipsum. Vestibulum ornare maximus leo. Quisque a nulla ac neque fermentum ultricies a non diam. Aliquam nec iaculis risus. Pellentesque gravida sollicitudin ipsum, at tristique velit.
    
    Sed tincidunt nulla eros, nec sollic eu fermentum nulla. Quisque et orci consequat lectus hendrerit faucibus id a nulla. Sed dignissim diam ut odio hendrerit, sed fringilla massa rutrum. Aliquam sollicitudin id massa sit amet vehicula. Quisque interdum tempus tristique. Aliquam erat volutpat. Sed dignissim diam id mi tristique, ac vulputate eros malesuada. Duis efficitur sem sed sagittis convallis.',
    covid: 'コロナ前',
    image: File.open(Rails.root.join('app', 'assets', 'images', 'post_sample.jpg'))
  )
end
end








 


# 追加のユーザーをまとめて生成する

# 99.times do 
# name = Faker::Games::Pokemon.name
# email = Faker::Internet.email
# avatar = Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg") 
# password = "password"
# User.create!(
#       avatar: avatar,
#       name:  name,
#       email: email,
#       year: "5年",
#       bio: "hello!hello!hello!hello!",
#       password:              password,
#       password_confirmation: password,
#       activated: true,
#       activated_at: Time.zone.now)


#適当にrelationshipを作る。
# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }

# endこのエンドは、必ずあとでコメントアウトする。

# 10.times do
#   content = Faker::Lorem.sentence(word_count: 1000)
#   tag = "移住"
#   users.each { |user| user.posts.create!(content: content) }
#   users.each { |user| user.posts.create!(tag: tag) }
# end