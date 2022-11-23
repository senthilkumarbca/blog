class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create!(params[:comment].permit(:body, :user_id))
    redirect_to topic_post_path(@post.topic_id, @post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to topic_post_path(@post.topic_id, @post)
  end
end
