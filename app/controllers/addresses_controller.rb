class AddressesController < ApplicationController

	def new
		@address = Address.new
	end


	def search
		@addresses = Address.search(params[:term], fields: ["jalan", "state", "country"], mispellings: {below: 5})
        if @addresses.blank?
          redirect_to root_path, flash:{danger: "no successful search result"}
        else
        	@listings = []
        	@addresses.results.each do |a|
        			if Listing.find_by(address_id: a.id) != nil
        				@listings << Listing.find_by(address_id: a.id)
        			end
					end
          render :result
        end	
	end

	def create
		@address = Address.new(address_params)
		if @address.save
			redirect_to "/addresses/#{@address.id}/listings/new"
		else
			# error_message
			render :new
		end
	end

	private
	def address_params	
		params.require(:address).permit(:jalan, :state, :country)
	end
end
