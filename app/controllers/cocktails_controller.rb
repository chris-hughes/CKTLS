class CocktailsController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :new, :create]
	before_filter :admin_user,	   only: :destroy

	def show
		@cocktail = Cocktail.find(params[:id])
	end

	def index
		@cocktails = Cocktail.paginate(page: params[:page])
		if signed_in?
			@user = User.find_by_email(current_user.email)
		end
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

	def destroy
	    Cocktail.find(params[:id]).destroy
	    flash[:success] = "Cocktail destroyed."
	    redirect_to cocktails_url
    end

	private

		def signed_in_user
			store_location
      		redirect_to signin_url, notice: "Please sign in." unless signed_in?
    	end

  		def admin_user
  			redirect_to(root_path) unless current_user.admin?
  		end

end