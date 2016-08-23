class ReservationsController < ApplicationController
	
	def new
		@reservation = Reservation.new(listing_id: params[:listing_id])
		@listing = Listing.find(params[:listing_id])
	end

	def create
		a = start_date
		b = end_date
		@reservation = Reservation.new(start_date: a, end_date: b)
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:listing_id]		
		@host = "dicksonlyr@gmail.com"
		if @reservation.save
			# action mailer that will deliver straight?
			# ReservationMailer.notification_email(current_user.email, @host, @reservation.listing.id, @reservation.id).deliver_now
			
			# active job that will keep mails and perform later
	    ReservationJob.perform_later(current_user, @host, @reservation.listing.id, @reservation.id)
	    # call out reservation job to perform the mail sending task after @reservation is successfully saved
			redirect_to "/reservations/#{@reservation.id}"
		else
			
			# error_message
			render :new
		end
	end

	private
	def start_date	
		start_date_string = params[:reservation][:start_date]
		return start_date = datetify(start_date_string).to_date
		# byebug
	end

	def end_date
		end_date_string = params[:reservation][:end_date]
		return end_date = datetify(end_date_string).to_date
		# byebug
	end

	def datetify(date)
		mth = date[0..2]
		day = date[3..5]
		yr = date[6..9]
		day + mth + yr
	end
end
