class ListingsController < ApplicationController
	before_action :set_listing, only:[:show, :update, :destroy, :edit]

	def index
		listings = Listing.where(user_id: current_user.id)
		@listings = listings.order('id ASC')
	end

	def new
		@listing = Listing.new
		@address = Address.find(params[:address_id])
	end

	def create
		@listing = Listing.new(listing_params)
		@listing.address_id = params[:address_id]
		@listing.user_id = current_user.id		
		if @listing.save
			redirect_to listings_path
		else
			# error_message
			render :new
		end
	end

	def edit
	end

	def update
		if @listing.update_attributes(listing_params)
			redirect_to listings_path
		else
			render 'edit'
		end
	end

	def destroy
    @listing.destroy
    redirect_to listings_path
	end

	private
	def listing_params	
		params.require(:listing).permit(:place_name, :place_type, :address_id, :bedroom, :bath, :amenity, :cost_per_night, :description, {images:[]})
	end

	def set_listing
		@listing = Listing.find(params[:id])
	end
end
