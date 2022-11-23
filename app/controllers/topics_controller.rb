# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, if: :json_request?
  skip_before_action :authenticate_user!, if: :json_request?
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  # GET /topics or /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.json { render json: @topics, status: 200 }
      format.html { render :index, status: 200 }
    end
  end

  # GET /topics/1 or /topics/1.json
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.json { render :show, status: 200 }
      format.html { render :show, status: 200 }
    end
  end

  def render_404
    render json: { error: "Not found", status: 404 }
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit; end

  # POST /topics or /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        UserMailer.sign_up_mail(@topic).deliver_now
        format.html { redirect_to topic_url(@topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_url(@topic), notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def topic_params
    params.require(:topic).permit(:title)
  end
end
