class AddressesController < ApplicationController

	def new
		@address = Address.new
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
