class Post < ApplicationRecord
  # 投稿が消されたら、コメントも一緒に消す。
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  # view数 
  is_impressionable counter_cache: true
 
  #画像アップロードCarrierWave(imageはカラム。)
  mount_uploader :image, ImageUploader
  #rails6リッチテキスト
  # has_rich_text :content
  #rails active_storage:installによって可能に。
  # has_many_attached :image
   validates :user_id, presence: true
   validates :content, presence: true, length: { maximum: 5000 }
   validates :title, presence: true, length: { maximum: 30 }
  #  validates :tag, presence: true, length: { maximum: 10 }
   validates :covid, presence: true
  #  validates :image, presence: true
   #/post/newで投稿を作ると、user.rbのこれ↓が機能しなかったから。
  default_scope -> { order(created_at: :desc) }

  def self.search(search)
    if search
      # Post.where(['content LIKE ?', "%#{search}%"])
      Post.where(["content LIKE ? or title Like ?", "%#{search}%", "%#{search}%"])
    else
      Post.all.order(created_at: :desc) 
    end
  end

  #画像サイズの制限
#   validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
#     message: "must be a valid image format" },
# size:         { less_than: 5.megabytes,
#     message: "should be less than 5MB" }

   #画像サイズが1000*1000を超えないように。
    # def display_image
    #   image.variant(resize_to_limit: [1000, 1000])
    # end
end
