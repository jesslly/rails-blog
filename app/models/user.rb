class User < ActiveRecord::Base

	validates :email, presence: true
	validates_format_of :email, :with => /@/
	validates :password, :length => {:within => 6..40}

	has_secure_password

	before_create :confirmation_token

	def confirmation_token
    	if self.confirm_token.blank?
      		self.confirm_token = SecureRandom.urlsafe_base64.to_s
    	end
  	end

  	def email_activate
      self.email_confirmed = true
      self.confirm_token = nil
      save!(:validate => false)
    end
end
