class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		#session[:user_id] = @user.id
      UserMailer.registration_confirmation(@user).deliver
  		redirect_to root_url, notice: 'Account created successfully'
  	else 
  		flash[:error] = 'An error occured!'
  		render "new"
  	end
  end

  def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        flash[:success] = "Welcome! Your email has been confirmed"
        redirect_to login_url
      else
        flash[:error] = "Sorry. User does not exist."
        redirect_to root_url
      end
  end

  private
  	def user_params
  	  params.require(:user).permit(:email, :password, :password_confirmation)
  	end

end
