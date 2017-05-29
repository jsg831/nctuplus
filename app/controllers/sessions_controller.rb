class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(user_id: params[:session][:user_id].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = '成功登入'
      log_in user
      redirect_to user
    else
      flash[:danger] = '錯誤帳號/密碼'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
