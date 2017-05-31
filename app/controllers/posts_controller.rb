class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    redirect_to root_url
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "發文成功!"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "發文失敗!"
      redirect_to user_path(current_user)
    end
  end

  def edit
    @post = current_user.posts.find_by(id: params[:id])
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "修改成功!"
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "成功刪除"
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:post_type, :title, :is_public)
  end

  def correct_user
    if !logged_in?
      flash[:danger] = "請登入!"
      redirect_to login_url
    else
      @post = current_user.posts.find_by(id: params[:id]) if logged_in?
      if @post.nil?
        flash[:danger] = "僅能修改自己的發文"
        redirect_to user_path(current_user)
      end
    end
  end
end
