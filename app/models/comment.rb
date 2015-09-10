class Comment < ActiveRecord::Base

  scope :recent, -> { order(:updated_at) }

  paginates_per 5

  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: :author_id
  
  include Commentable
  #has_many :subcomments, class_name: "Comment", foreign_key: "parent_comment_id", dependent: :destroy
 
  #belongs_to :parent_comment, class_name: "Comment"
end