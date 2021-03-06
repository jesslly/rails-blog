class UserMailer < ActionMailer::Base
	default :from => "test@gmail.com"

	def registration_confirmation(user)
		@user = user
		mail(:to => "<#{user.email}>", :subject => "Registration Confirmation")
	end
end