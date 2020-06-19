class Driver < User
  $max_distance_limit = 50.0
  belongs_to :car, optional: true

  scope :available_drivers, -> { where(available: true ).order(created_at: 'desc') }


  def self.nearest(lat, long)
    nearest_driver = nil
    shortest_distance = Float::INFINITY
    available_drivers.each do |driver|
      distance = Math.sqrt((lat - driver.lat)**2 + (long - driver.lat)**2)
      if distance < shortest_distance && distance <= $max_distance_limit
        shortest_distance = distance
        nearest_driver = driver
      end
    end
    nearest_driver
  end
end
