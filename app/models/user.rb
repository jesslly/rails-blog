class User < ActiveRecord::Base

	validates :email, presence: true
	validates_format_of :email, :with => /@/
	validates :password, :length => {:within => 6..40}

	has_secure_password
end
