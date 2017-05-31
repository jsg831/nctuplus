class UsersController < ApplicationController
  # Validate user permission
  # Only logged-in users can edit or update their "own" profile.
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    if current_user?(@user)
      @post = current_user.posts.build
      @edit_post = nil
      @news = @posts.where(post_type: 1)
      @updates = @posts.where(post_type: 2)
    else
      @news = @posts.where(post_type: 1, is_public: true)
      @updates = @posts.where(post_type: 2, is_public: true)
    end
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "註冊成功!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "修改成功!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_id, :name, :password, :password_confirmation)
  end

  # Check if the user is editing or updating their own profile.
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = "僅能修改自己的資料"
      redirect_to root_url
    end
  end
end
