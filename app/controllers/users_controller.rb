class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user_params = create_params[:user]
    if ((user_params.has_key?("type")) and (user_params[:type]=="Rider" or user_params[:type]=="Driver"))
      @user = User.new(create_params[:user])
      @user.save!
      response = { status: :success, user: @user.as_json }
    else
      response = { status: :failure, message: "incorrect params" }
    end
      render json: response
  end

  def index
    render json: { }, status: :ok
  end

  def update_location
    @user = User.find(update_params[:id])
    @user.update!(update_params)
    response = { status: :success, message: "Updated location" }
    render json: response
  end

  def booking_history
    @rider = Rider.find(params[:id])
    response = { status: :success, bookings: @rider.bookings }
    render  json: response
  end

  def update_availablity
    @user = User.find(update_params[:id])
    @user.update_availablity(update_params[:available])
    if @user.available?
      response = { status: :success, message: "Driver is available" }
    else
      response = { status: :failure, message: "Driver not available" }
    end
    render json: response
  end


  private

  def create_params
    params.permit(user: [:name, :long,:lat,:type])
  end

  def update_params
    params.permit(:id, :long, :lat, :available)
  end

end
