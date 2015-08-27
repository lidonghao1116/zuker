class CommentPolicy < ApplicationPolicy
  def new_comment?
    user.verified? && record.commentable != user && record.commentable.try(:owner) != user
  end
end