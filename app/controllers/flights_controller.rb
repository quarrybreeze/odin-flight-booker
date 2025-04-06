class FlightsController < ApplicationController
  def index
    @departing_airport_options = Airport.all.map { |a| [ a.iata, a.id ] }
    @arriving_airport_options = Airport.all.map { |a| [ a.iata, a.id ] }
    @departure_date_options = Flight.all.map { |flight| [ flight.start.strftime("%Y-%m-%d"), flight.start.to_date] }.sort_by { |date_str, date| date }.uniq { |date_str, date| date_str }

    if params[:flight].present?
      flight_params = params[:flight]
      date = Date.parse(flight_params[:start]) rescue nil
      @search_results = Flight.includes(:departure_airport, :arrival_airport)
        .order(start: :asc)
        .where(
          departure_airport_id: flight_params[:departure_airport_id],
          arrival_airport_id: flight_params[:arrival_airport_id]
      ).where(start: date.beginning_of_day..date.end_of_day) if date
      @num_tickets = flight_params[:num_tickets]
    else
      # @search_results = Flight.none
    end
  end

  private
  def flight_params
    params.require(:flight).permit(:departure_airport_id, :arrival_airport_id, :start, :num_tickets)
  end
end
