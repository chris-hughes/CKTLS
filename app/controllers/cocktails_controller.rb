class CocktailsController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :new, :create]
	before_filter :admin_user,	   only: :destroy

	def show
		@cocktail = Cocktail.find(params[:id])
		@tools = @cocktail.tools.all
		@ingredients = @cocktail.ingredients.all
		@directions = @cocktail.directions.all
	end

	def index		
		if signed_in?
			@user = User.find_by_email(current_user.email)
		end

		@cocktails = case params[:family]
        	when "fruity" 		then Cocktail.where("family = ?", "Fabulously Fruity")
        									 .paginate(page: params[:page], per_page: 5)
        	when "cool" 		then Cocktail.where("family = ?", "Cool and Refreshing")
        									 .paginate(page: params[:page], per_page: 5)
        	when "sparkling" 	then Cocktail.where("family = ?", "Sparkling Gems")
        									 .paginate(page: params[:page], per_page: 5)
        	when "tangy" 		then Cocktail.where("family = ?", "Tangy Tongue Teasers")
        									 .paginate(page: params[:page], per_page: 5)
        	when "winter" 		then Cocktail.where("family = ?", "Winter Warmers")
        									 .paginate(page: params[:page], per_page: 5)
        	when "rich" 		then Cocktail.where("family = ?", "Rich and Creamy")
        									 .paginate(page: params[:page], per_page: 5)
        	when "shots" 		then Cocktail.where("family = ?", "Sensational Shots")
        									 .paginate(page: params[:page], per_page: 5)
        	else 					 Cocktail.paginate(page: params[:page], per_page: 5)
        end
	end

	def new
		@cocktail = Cocktail.new
		@cocktail.tools.build
		@cocktail.ingredients.build
		@cocktail.directions.build
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
		@cocktail = Cocktail.includes(:tools).where("cocktails.id=#{params[:id]}").first
		@cocktail = Cocktail.find(params[:id])
		if @cocktail.update_attributes(params[:cocktail])
			flash[:success] = @cocktail.name.titleize+" updated!"
			redirect_to @cocktail
		else
			render 'edit'
		end
	end

	def destroy
	    Cocktail.find(params[:id]).destroy
	    flash[:success] = "Cocktail destroyed."
	    redirect_to cocktails_url
    end

end
