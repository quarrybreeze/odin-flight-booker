class FlightsController < ApplicationController
  def index
    @departing_airport_options = Airport.all.map { |a| [ a.iata, a.id ] }
    @arriving_airport_options = Airport.all.map { |a| [ a.iata, a.id ] }
    @departure_date_options = Flight.all.map { |flight| [ flight.departure_date_formatted, flight.id ] }.uniq { |date, id| date }
  end
end
