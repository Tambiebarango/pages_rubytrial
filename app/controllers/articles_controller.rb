class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @article_list = Article.paginate(page: params[:page], per_page: 3)
    end

    def new
        @article = Article.new
    end

    def create
        
        @article = Article.new(article_params)
        @article.user_id = session[:user_id]
        if @article.save
            flash.now[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            flash.now[:error] = "Something went wrong, try again."
            render 'new'
        end
    end

    def show
    end

    def edit
    end

    def update
        permitted_attributes = params.require(:article).permit(:title, :description, category_ids:[])
        @article.update_attributes(permitted_attributes)

        redirect_to article_path(@article)
    end

    def destroy
        @article.destroy

        redirect_to articles_path
    end
    private
        def article_params
            params.require(:article).permit(:title, :description, category_ids:[])
        end

        def set_article
            @article = Article.find(params[:id])
        end

        def require_same_user
            if logged_in? and @article.user_id != current_user[:id]
                flash[:error] = "You can only update your own articles!"
                redirect_to root_path
            end
        end
    
   
     
end