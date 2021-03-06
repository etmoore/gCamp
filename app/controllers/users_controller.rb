class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
    raise AccessDenied unless @user == current_user || current_user.admin?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User successfully created."
    else
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    raise AccessDenied unless @user == current_user || current_user.admin?
    @user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed.'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if current_user.admin?
        params.require(:user).permit( :first_name,
                                      :last_name,
                                      :email,
                                      :password,
                                      :password_confirmation,
                                      :tracker_token,
                                      :admin)
      else
        params.require(:user).permit( :first_name,
                                      :last_name,
                                      :email,
                                      :password,
                                      :password_confirmation,
                                      :tracker_token)
      end
    end
end
