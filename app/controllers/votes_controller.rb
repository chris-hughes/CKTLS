class VotesController < ApplicationController
	before_filter :signed_in_user

	def create
		@user = User.find_by_email(current_user.email)
		@cocktail = Cocktail.find_by_id(params[:vote][:cocktail_id])
		current_user.vote!(@cocktail)
		redirect_to @cocktail
	end

	def destroy
		@user = User.find_by_email(current_user.email)
		@cocktail = Vote.find(params[:id]).cocktail
		current_user.unvote!(@cocktail)
		redirect_to @cocktail
	end

end