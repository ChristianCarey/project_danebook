class UsersController < ApplicationController
  before_action      :require_current_user, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user,    only: [:new, :create]

  def index
    @users = User.search_by_name(params[:query])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      params[:remember] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "Welcome to Danebook. Tell us a bit about yourself."
      sign_in(@user)
      User.delay.send_welcome_email(@user.id) 
      redirect_to edit_user_profile_path(@user)
    else
      flash[:danger] = "Try signing up again."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def require_current_user
    unless current_user.id.to_s == params[:id]
      flash[:danger] = "Sorry, you're not authorized for that."
      redirect_back_or(root_path)
    end
  end
end
