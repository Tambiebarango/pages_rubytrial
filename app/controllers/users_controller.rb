class UsersController < ApplicationController
    before_action :set_user, only:[:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        @user_list = User.paginate(page: params[:page], per_page: 3)
    end
    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            flash[:success] = "Account successfully created"
            session[:user_id] = @user.id
            redirect_to user_path(@user)
            
        else
            flash[:error] = "Signup unsuccessful"
            render 'new'

        end
    end

    def show
        
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end

    def edit
    end

    def update
        if @user.authenticate(user_params["password"])
            if @user.update(user_params)
                flash[:success] = "Account successfully updated"
                redirect_to articles_path
            else
                flash[:error] = "Update unsuccessful"
                render 'new'
            end
        else
            flash[:error] = "Password incorrect. Try again"
            render 'new'
        end
    end

    def destroy
        if @user = current_user
            session[:user_id] = nil
        end
        @user.destroy
        flash[:success] = "User has been successfully deleted!"
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if @user.id != current_user[:id]
            flash[:error] = "You can only perform this action on your profile!"
        end
    end
end