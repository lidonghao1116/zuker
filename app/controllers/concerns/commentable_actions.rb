module CommentableActions
  extend ActiveSupport::Concern

  included do    
    #before_action :has_verify_phone?, only:[:new_comment]
    #after_action :verify_authorized, only: [:new_comment]
  end

  class_methods do
  end

  def new_comment
    @obj = controller_name.singularize.camelize.constantize.find(params[:id])
    @comment = @obj.comments.new(comment_params)
    authorize @comment
    @comment.author_id = current_user.id
    if @comment.save
      #flash[:success] = t('flash.messages.success')
    else
      flash[:danger] = t('flash.messages.failed')
    end
    redirect_to :back
  end

  def reply
    @comment = Comment.find(params[:id])
    @reply = @comment.comments.new(comment_params)
    authorize @reply
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

    # def user_not_authorized
    #   unless current_user.verified
    #     flash[:danger] = "Hey, please verify your phone number first."
    #     redirect_to phone_verify_user_path(current_user) and return
    #   end
    #   flash[:alert] = "You can't comment on yourself."
    #   redirect_to(request.referrer || root_path)
    # end

end