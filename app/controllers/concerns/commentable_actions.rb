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

  private

    def comment_params
      params.require(:comment).permit(:author_id, :content)
    end

end