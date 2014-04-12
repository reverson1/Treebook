class UsersController < ActionController::Base
 
  def create
    @user = User.new(user_params)
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.profile_name = params[:user][:profile_name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.remember_me = params[:user][:remember_me]
  end

  private
  def user_params
    params.require(:user).permit(:first_name)
    params.require(:user).permit(:last_name)
    params.require(:user).permit(:profile_name)
    params.require(:user).permit(:email)
    params.require(:user).permit(:password)
    params.require(:user).permit(:password_confirmation)
    params.require(:user).permit(:remember_me)
  end  
end
