module CommentableActions

  extend ActiveSupport::Concern

  class_methods do
  end

  def new_comment
    @comment = @house.comments.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      #flash[:success] = t('flash.messages.success')
    else
      flash[:danger] = t('flash.messages.failed')
    end
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:author_id, :content)
    end   

end