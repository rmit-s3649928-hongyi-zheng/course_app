class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def index
   @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @courses = @user.courses
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = "Sign up successfully!"
      redirect_to home
    else
      errors = ["Please correct following errors:","Name cant be blank","Name is too short(minimum is 4)","Email cannot be blank","Email is too short(minimum is 4)","Email registration is only for RMIT staff","Pass word cant be blank","Password must contain at least one uppercase letter, one lowercase letter, one number, one special character and 8+characters"]
      flash.now[:danger] = errors.join("<br>").html_safe
      render 'new'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      errors = ["Please correct following errors:","Name cant be blank","Name is too short(minimum is 4)","Email cannot be blank","Email is too short(minimum is 4)","Email registration is only for RMIT staff","Pass word cant be blank","Password must contain at least one uppercase letter, one lowercase letter, one number, one special character and 8+characters"]
      flash.now[:danger] = errors.join("<br>").html_safe
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    
end
