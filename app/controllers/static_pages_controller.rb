class StaticPagesController < ApplicationController
	
	def home
		if signed_in?
			@user = User.find_by_email(current_user.email)
		end
	end

	def cocktails
	end

	def learn
	end

	def about
	end
	
	def contact
	end
	
end
