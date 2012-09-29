class CocktailsController < ApplicationController

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
			redirect_to cocktails_path
		else
			render 'new'
		end
	end

end
