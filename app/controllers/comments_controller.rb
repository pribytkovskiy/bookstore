class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    redirect_to product_path(locale: I18n.locale, id: params[:comment][:product_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:product_id, :rate, :title, :body, :user_id)
  end
end
