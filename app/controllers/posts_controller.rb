# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_topic
  before_action :set_post, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /posts or /posts.json
  def index
    if params[:user_id]
      @posts = Post.includes(:tags, :topic, :taggables).where(user_id: params[:user_id]).page(params[:page])
    else
      top = params[:topic_id]
      start_date = params[:start_date].nil? ? Date.yesterday : params[:start_date]
      end_date = params[:end_date].nil? ? Date.tomorrow : params[:end_date]
      @posts = @topic.posts.includes(:topic, :taggables, :tags).page(params[:page]) unless top.nil?
      @posts = Post.includes(:tags, :topic, :taggables).filter_by_date(start_date, end_date).page(params[:page]) if top.nil?
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @ratings = @post.ratings.order(star: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
    # @post = @topic.posts.build
  end

  # GET /posts/1/edit
  def edit

  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.except(:tags))
    @post.user = current_user
    # @post = @topic.posts.build(post_params)
    create_or_delete_posts_tags(@post, params[:post][:tags], params[:post][:tag_new])

    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_posts_path(@post.topic_id), notice: 'Post was successfully created.' }
        # format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize! :update, @post, :message => "Unable to read this article."
    create_or_delete_posts_tags(@post, params[:post][:tags], params[:post][:tag_new])
    respond_to do |format|
      if @post.update(post_params.except(:tags))
        format.html { redirect_to topic_post_path(@topic, @post), notice: 'Post was successfully updated.' }
        # format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize! :destroy, @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post was successfully destroyed.' }
      # format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def create_or_delete_posts_tags(post, tags, tag_new)
    post.taggables.destroy_all
    post.tags << Tag.find_or_create_by(name: tag_new.strip) if tag_new.length.positive?
    tags&.each do |tag|
      post.tags << Tag.find_or_create_by(name: tag) if tag.length.positive?
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
    # @post = @topic.posts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :topic_id, :tags, :image)
  end

  # @return [Topic]
  def get_topic
    top = params[:topic_id]
    @topic = Topic.find(params[:topic_id]) unless top.nil?
  end
end
