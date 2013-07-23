class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :subscribe_to, :unsubscribe_to]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    params.permit!
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  # POST /topics/1/subscribe_to
  # POST /topics/1/subscribe_to.json
  def subscribe_to
    if user_signed_in? and @topic
      Subscription.create(user_id: current_user.id, topic_id: @topic.id)
    end

    respond_to do |format|
      format.html { redirect_to topics_path, notice: 'Topic was successfully subscribed to.'}
      format.json { head :no_content }
    end
  end

  # DELETE /topics/1/unsubscribe_to
  # DELETE /topics/1/unsubscribe_to.json
  def unsubscribe_to
    if user_signed_in? and @topic
      topic_to_destroy = Subscription.find_by(topic_id: @topic.id, user_id: current_user.id)
      topic_to_destroy.destroy
    end

    respond_to do |format|
      format.html { redirect_to topics_path, notice: 'Topic was successfully unsubscribed to.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :image)
    end
end
