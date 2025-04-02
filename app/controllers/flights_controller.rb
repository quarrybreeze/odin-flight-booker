class FlightsController < ApplicationController
  def index
    @departing_airport_options = Airport.all.map { |a| [ a.iata, a.id ] }
    @arriving_airport_options = Airport.all.map { |a| [ a.iata, a.id ] }
    @departure_date_options = Flight.all.map { |flight| [ flight.start.strftime("%Y-%m-%d"), flight.start.to_date ] }.uniq { |date_str, id| date_str }

    if params[:start].present?
      date = Date.parse(params[:start]) rescue nil
      @search_results = Flight.includes(:departure_airport, :arrival_airport).order(start: :asc).where(
        departure_airport_id: params[:departure_airport_id],
        arrival_airport_id: params[:arrival_airport_id]
      ).where(start: date.beginning_of_day..date.end_of_day) if date
    else
      @search_results = Flight.none
    end
  end

  private
  def search_params
    params.permit(:departure_airport_id, :arrival_airport_id, :start, :num_tickets, :commit)
  end
end
