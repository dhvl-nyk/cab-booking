class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  scope :available_cabs, -> { where(status: 'available').order(created_at: 'desc') }


  # def self.nearest(lat, long)
  #   nearest_cab = nil
  #   shortest_distance = Float::INFINITY
  #   Driver.where("available":true).each do |cab|
  #     distance = Math.sqrt((lat - cab.lat)**2 + (long - cab.lat)**2)
  #     if distance < shortest_distance
  #       shortest_distance = distance
  #       nearest_cab = cab
  #     end
  #   end
  #   nearest_cab
  # end
end
