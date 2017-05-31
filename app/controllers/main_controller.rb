class MainController < ApplicationController
  def index
    @user = current_user
    @post = nil
    @news = Post.where(post_type: 1, is_public: true)
    @updates = Post.where(post_type: 2, is_public: true)
  end
end
