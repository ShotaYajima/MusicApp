class HomeController < ApplicationController

  before_action :forbid_login_user,{only: [:top]}
  def top
    @posts = Post.order(created_at: :desc).limit(4)
  end

  def about
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
