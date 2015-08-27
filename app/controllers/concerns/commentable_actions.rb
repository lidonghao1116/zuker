module CommentableActions

  extend ActiveSupport::Concern

  included do    
    before_action :has_verify_phone?, only:[:new_comment]
    before_action :find_parent_comment, only: [:reply]
  end

  class_methods do
  end

  def new_comment
    redirect_to root_path unless current_user
    @obj = controller_name.singularize.camelize.constantize.find(params[:id])
    # before_action :set_user
    @comment = @obj.comments.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      #flash[:success] = t('flash.messages.success')
    else
      flash[:danger] = t('flash.messages.failed')
    end
    redirect_to :back
  end

  def reply
    # before_action :set_user_by_user_id
    @reply = @comment.comments.new(comment_params)
    @reply.author_id = current_user.id
    if @reply.save
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

    def find_parent_comment
      @comment = Comment.find(params[:comment_id]) if params[:comment_id]
    end

end