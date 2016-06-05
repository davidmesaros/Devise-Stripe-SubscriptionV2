class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show] 
  before_action :require_user_same, only: [:edit, :update, :destroy]
  before_action :require_admin
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
    # @users = User.all
    delinquent # get called at application for User#index
  end
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    
    if @user.update(user_params)
      flash[:success] = "your account has been update successfully"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  # def create
  #   # debugger
  #   @user = User.new(user_params)
  #   # debugger
  #   if @user.save
  #     session[:user_id] = @crea.id
  #     flash[:success] = "You have signed up => congrat #{@create_user.username}"
  #     redirect_to user_path(@create_user)
  #   else

  #     render 'new'
  #   end

  # end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all Website's - Ad's - Data - Dashboard will be deleted"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :subscribed, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_user_same
      if current_user != @user && !current_user.admin?
        flash[:danger] = "This Page is not Accessible"
        redirect_to root_path
      end
    end

    def require_admin
      if logged_in? && !current_user.admin
      flash[:danger] = "Only Admin can Assess this Page"
      redirect_to root_path
      end      
    end

end