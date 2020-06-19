class Booking < ApplicationRecord
  has_many :user_booking_relations
  has_many :users, through: :user_booking_relations

  def book(driver, lat, long)
    update_attributes(car_id: driver.car.id, starting_lat: lat, starting_long: long, status: 'scheduled')
  end

  def end_trip(lat, long)
      update_attributes(ending_lat: lat,
                        ending_long: long,
                        status: 'completed',
                        end_time: Time.now)
  end
end
