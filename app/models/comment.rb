class Comment < ApplicationRecord
  belongs_to :post
<<<<<<< HEAD
  belongs_to :parent_comment, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_comment_id, dependent: :destroy
=======
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
>>>>>>> refs #3 Create table, validates, add associations.
  validates :content, presence: true
end
