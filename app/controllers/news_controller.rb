class NewsController < ProtectForgeryApplication

  before_action  :authenticate_user!
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # before_action :find_optional_user
  before_action :authorize, only: [:new, :create]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /news
  # GET /news.json
  def index
    @news = News.includes(:user).order('id DESC').paginate(page: params[:page], per_page: 25)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @case = true
  end

  # GET /news/new
  def new
    @news = News.new(user_id: User.current.id)
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_news
    @news = News.includes(:user, :post_attachments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def news_params
    params.require(:news).permit(News.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @news.can?(:edit_news, :manage_news, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @news.can?(:delete_news, :manage_news, :manage_roles)
  end

end
