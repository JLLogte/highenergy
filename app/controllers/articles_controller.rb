class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :get_image]
  before_action :set_topic

  # GET topics/#/articles
  # GET topics/#/articles.json
  def index
    @articles = @topic.articles.order("created_at DESC")
  end

  # GET topics/#/articles/#
  # GET topics/#/articles/#.json
  def show
  end

  # GET topics/#/articles/new
  def new
    @article = Article.new
  end

  # GET topics/#/articles/#/edit
  def edit
  end

  # POST topics/#/articles
  # POST topics/#/articles.json
  def create
    @article = Article.new(article_params)
    @article.topic_id = @topic.id

    respond_to do |format|
      if @article.save
        format.html { redirect_to topic_article_path(@topic, @article), notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT topics/#/articles/#
  # PATCH/PUT topics/#/articles/#.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to topic_article_path(@topic,@article), notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE topics/#/articles/#
  # DELETE topics/#/articles/#.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:name, :content, :image, :source_url)
    end
end
