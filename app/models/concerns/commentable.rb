module Commentable
  extend ActiveSupport::Concern

  included do 
    has_many :comments, as: :commentable 
  end

  def my_comments
    raise "#{self} is not an User" unless self.model_name.name == 'User'
    return Comment.where(author_id: id)
  end

  module ClassMethods     
    def least_commented
      #returns the article/event which has the least number of comments
    end
  end 
end