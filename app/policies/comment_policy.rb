class CommentPolicy < ApplicationPolicy
  def new_comment?
    # user is verfied
    if @user.verified?
      if record.commentable.class.name != 'Comment'
        # if this is new comment
        # He must be neither landlord nor current_user
        record.commentable.try(:owner) != @user && record.commentable != @user
      end
    else
      false
    end
  end

  def reply?
    # user is verfied
    if @user.verified?
      if record.commentable.class.name == 'Comment'
        # if this is a reply
        # He must be landlord or current_user
        record.commentable.commentable.try(:owner) == @user || record.commentable.commentable == @user
      end
    else
      false
    end
  end

end