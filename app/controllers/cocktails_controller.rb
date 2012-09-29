class CocktailsController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :destroy]

	def show
		@cocktail = Cocktail.find(params[:id])
	end

	def index
	end

	def new
		@cocktail = Cocktail.new
	end

	def create
		@cocktail = Cocktail.new(params[:cocktail])
		if @cocktail.save
			flash[:success] = @cocktail.name.titleize+" added to CKTLS!"
			redirect_to @cocktail
		else
			render 'new'
		end
	end

	def edit
		@cocktail = Cocktail.find(params[:id])
	end

	def update
		@cocktail = Cocktail.find(params[:id])
		if @cocktail.update_attributes(params[:cocktail])
			flash[:success] = @cocktail.name.titleize+" updated!"
			redirect_to @cocktail
		else
			render 'edit'
		end
	end

	private

		def signed_in_user
      		redirect_to signin_url, notice: "Please sign in." unless signed_in?
    	end

end
