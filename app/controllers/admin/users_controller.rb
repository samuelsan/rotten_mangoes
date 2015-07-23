class Admin::UsersController < ApplicationController

  before_filter :admin?

def index
    if session[:admin_user_id]
      session[:user_id] = session[:admin_user_id]
      session[:admin_user_id] = nil
    end
    @admin = User.find(session[:user_id])
    @users = User.all.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def admin?
    return if session[:admin_user_id]
    unless current_user && current_user.admin
      redirect_to movies_path
    end
  end


  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end