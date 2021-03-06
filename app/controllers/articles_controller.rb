class ArticlesController < ResourcesController
  skip_before_action :authenticate_user!, only: %i[index show view_modal]
  before_action :set_locale_to_record, only: %i[create update]

  respond_to :js, only: :view_modal

  def index
    @articles = Article.order(:id)
  end

  def show
    @article = record_class.find(params[:id])
    @comments = @article.comments.order(:id)
    @comment = Comment.new
    # UserMailer.welcome_email(current_user).deliver_later if current_user.present?
  end

  def new
    @article = Article.new
  end

  def create
    res = Articles::Operations::Create.call(record_params: record_params)
    if res.created?
      flash[:success] = MessageHelper.created(record_class.name)
      redirect_to articles_path
    else
      flash[:danger] = res.errors
      redirect_to new_article_path
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    res = Articles::Operations::Update.call(record: record, record_params: record_params)
    if res.ok?
      flash[:success] = MessageHelper.updated(record_class.name)
      redirect_to articles_path
    else
      flash[:danger] = res.errors
      redirect_to edit_article_path
    end
  end

  def destroy
    res = Articles::Operations::Destroy.call(record: record)
    if res.no_content?
      flash[:success] = MessageHelper.destroyed(record_class.name)
    else
      flash[:danger] = res.error
    end
    redirect_to articles_path
  end

  def view_modal
    @article = Article.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'view_modal_js', article: @article }
    end
  end

  private

  def record_params
    params.require(:article).permit!
  end

  def record_class
    Article
  end

  def set_locale_to_record
    I18n.locale = record_params[:locale]
  end
end
