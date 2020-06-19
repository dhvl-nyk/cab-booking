class User < ApplicationRecord
  has_many :user_booking_relations
  has_many :bookings, through: :user_booking_relations, :source => :user, :class_name => 'UserBookingRelation'

  scope :riders, -> { where(type: 'Rider') }
  scope :drivers, -> { where(type: 'Driver') }

  def update_availablity(status)
    update_attribute(:available, status)
  end
end
