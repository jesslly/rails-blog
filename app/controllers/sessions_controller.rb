class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])

		# If the user exists AND the password entered is correct.
		if user && user.authenticate(params[:password])
			# Save the user id inside the browser cookie. This is how we keep the user
			# logged in when they navigate around our website.

			if user.email_confirmed
				session[:user_id] = user.id
				redirect_to root_url
			else
				flash.now[:error] = 'Please activate your account by following the instructions in the account confirmation email'
				render "new"
			end
			
		else
			# If user's login doesn't work, send them back ot the login form
			redirect_to '/login'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/login'
	end
end
