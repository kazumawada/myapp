class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes
    # 自分がlikeした投稿
    has_many :liked_posts, through: :likes, source: :post
    
    #アバター
    mount_uploader :avatar, AvatarUploader
    #view数
    is_impressionable counter_cache: true
    ############following関係######################################
    has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
    has_many :following, through: :active_relationships, source: :followed#sourceの意味 → following配列の元はfollowedIdのかたまりであるという意味。
    has_many :followers, through: :passive_relationships, source: :follower
     ############following関係######################################
    default_scope -> { order(created_at: :desc) }
    attr_accessor :remember_token, :activation_token
    before_save   :downcase_email
    before_create :create_activation_digest
    #validation
    validates :name,  presence: true, length: { maximum: 100 }   
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 200 },
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: true
    validates :year,  presence: true, length: { maximum: 4 }#5年以上で4文字列分だから。
    validates :bio,  presence: true, length: { maximum: 300 }
     #User作成で、passwordとpassword_confirmation,authenticateが使える。DBテーブルにはないが。
     has_secure_password
     #password: パスワードが空でも、updateできるようにする。
     validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

     def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

  #sessionとtoken
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def session_token
    remember_digest || remember
  end

  # mailerのトークンとダイジェストが一致したか？
  # def authenticated?(attribute, token)
  #   digest = send("#{attribute}_digest")
  #   return false if digest.nil?
  #   BCrypt::Password.new(digest).is_password?(token)
  # end
  # #アカウントを有効化
  # def activate
  #   update_attribute(:activated,    true)
  #   update_attribute(:activated_at, Time.zone.now)
  # end
  # #アカウント有効のメールを送信する
  # def send_activation_email
  #   UserMailer.account_activation(self).deliver_now
  # end


  #全てのユーザーがfeedを持つから。(まだ完全ではない。)
  def feed
    Post.where("user_id = ?", id)#=posts
  end

  #####################followingメソッド###########################
  #<<は、配列の最後に追記するという意味。

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  #####################いいねのメソッド#########################################
  #likeテーブル内に、post_idが存在しているかどうか。
  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end

    private

        def downcase_email
            self.email = email.downcase
        end
    # 有効化トークンとダイジェストを作成および代入。ユーザーが作られる前にそのトークンとダイジェストが必要だから。
     def create_activation_digest
        self.activation_token  = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
end


