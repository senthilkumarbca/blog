class UserCommentRatingsController < ApplicationController
  before_action :set_post
  before_action :set_comment

  def index
    @user_comment_rating = UserCommentRating.new
    @user_comment_ratings = @comment.user_comment_ratings
  end

  def create
    @user_comment_rating = UserCommentRating.new(params[:user_comment_rating].permit(:comment_id, :star))
    @user_comment_rating.user_id = current_user.id
    respond_to do |format|
      if @user_comment_rating.save
        format.html { redirect_to post_comment_user_comment_ratings_path(@post,@comment) }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:comment_id])
  end

end
