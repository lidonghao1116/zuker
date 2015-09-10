class CommentsController < ApplicationController

  #before_action :set_user

  include CommentableActions

  private

    # def set_user
    #   redirect_to root_path, notice: "Please sign in or register first." unless current_user
    # end
  
end