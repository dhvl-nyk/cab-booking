class BookingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_valid_params

  def end
    trip = Booking.find(params[:id])
    if trip.end_trip(params[:lat], params[:long])
      response = { status: 'success', message: 'Ride End'}
    else
      response = { status: 'failure', message: 'Sorry.Could not end trip' }
    end
    render json: response
  end

  def book_nearest
    driver = Driver.nearest(params[:long].to_f, params[:lat].to_f)
    if driver.nil?
      response = { status: 'failure', message: 'Sorry no cabs are available' }
    else
      booking = Booking.new
      booking.book(driver, params[:long], params[:lat])
      booking.save!

      relation = UserBookingRelation.new
      relation.user_id = params[:user_id]
      relation.booking_id = booking.id
      relation.save!

      driver.available = false;
      driver.save!

      if booking
        response = { status: 'success', booking_id: booking.id, message: 'Booking Success' }
      else
        response = { status: 'failure', message: 'Sorry! Failed to book trip' }
      end
    end
    render json: response
  end

  def check_valid_params
    if params[:lat].nil? || params[:long].nil?
      render json: { status: 'failure', message: 'Bad Request! Please enter proper params' }, status: 400
    end
  end

  private

  def create_params
    params.permit(cab: [:registration_number, :status,:color,:modelname, :lat,:long])
  end

  def update_params
    params.permit(cab: [:lat,:long])
  end
end
