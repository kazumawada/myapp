class Comment < ApplicationRecord
    belongs_to :post, optional: true
    belongs_to :user
    validates :content,  presence: true, length: { maximum: 1000 }
end
