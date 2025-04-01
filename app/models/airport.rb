class Airport < ApplicationRecord
  validates :iata, length: { is: 3 }
  validates :iata, uniqueness: true

  has_many :departing_flights, class_name: "Flight", foreign_key: "departure_airport_id"
  has_many :arriving_flights, class_name: "Flight", foreign_key: "arrival_airport_id"
end
