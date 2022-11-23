class RatingsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.create(params[:rating].permit(:star, :user_id))
    redirect_to topic_post_path(@post.topic_id, @post)
  end
end
