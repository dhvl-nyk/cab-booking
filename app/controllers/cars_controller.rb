class CarsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def register_car_driver
    user_id = car_params[:user_id]
    @driver = Driver.find(user_id)
    if @driver.present?
      @car = Car.new(registration_number: car_params[:registration_number],
                     modelname: car_params[:modelname],
                     status: car_params[:status],
      )
      @car.save!
      @driver.car = @car
      @driver.save!
      response = { status: :success, message: "Car resgistered" }
    else
      response = { status: :failure, message: "User not present" }
    end
    render json: response
  end

  private

  def car_params
    params.permit(:registration_number, :modelname, :status, :user_id)
  end

end
