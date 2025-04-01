class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"

  def departure_date_formatted
    start.strftime("%m/%d/%Y")
  end
end
