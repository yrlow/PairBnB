class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new(listing_id: params[:listing_id])
		@listing = Listing.find(params[:listing_id])
	end

	def create
		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:listing_id]		
		if @reservation.save
			redirect_to "/reservations/#{@reservation.id}"
		else
			# error_message
			render :new
		end
	end

	private
	def reservation_params	
		params.require(:reservation).permit(:start_date, :end_date)
	end
end
