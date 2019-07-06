class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]

    def new
        @category = Category.new()
    end

    def create
        @category = Category.create(categories_params)
        if @category.save
            flash[:success] = "Category was successfully created"
            redirect_to categories_path
        else
            flash[:error] = "Something went wrong! Please try again"
            render 'new'
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(categories_params)
            flash[:success] = "Category has been successfully updated."
            redirect_to category_path(category)
        else
            flash[:error] = "Something went wrong. Try again"
            render 'edit'
        end
    end
    def index
        @categories = Category.all.paginate(page: params[:page], per_page: 3)
    end
    
    

    def show
        @category = Category.find(params[:id])
        @category_articles = @category.articles.all.paginate(page: params[:page], per_page: 3)

    end

    private
    def categories_params
        params.require(:category).permit(:name)

    end
    def require_admin
        if !logged_in? or (logged_in? and !current_user.admin?)
            flash[:error] = "Only admins can perform that action"
            redirect_to categories_path
        end
    end
end
