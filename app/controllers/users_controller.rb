class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = "Sign up successfully!"
      redirect_to @user
    else
      errors = ["Please correct following errors:","Name cant be blank","Name is too short(minimum is 4)","Email cannot be blank","Email is too short(minimum is 4)","Email registration is only for RMIT staff","Pass word cant be blank","Password must contain at least one uppercase letter, one lowercase letter, one number, one special character and 8+characters"]
      flash.now[:danger] = errors.join("<br>").html_safe
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
end
