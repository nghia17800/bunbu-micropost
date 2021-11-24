class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js {}
      end
    else
      flash[:danger] = "Invalid comment"
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js {}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :parent_comment_id)
  end
end
