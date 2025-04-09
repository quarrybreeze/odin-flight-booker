class BookingsController < ApplicationController
  def index
  end

  def show
    @booking = Booking.includes(:flight).find(params[:id])
    @passengers = @booking.passengers
    @passenger = Passenger.new
  end

  def new
    @flight_id = booking_params[:flight_id]
    @num_tickets = booking_params[:num_passengers]

    @booking = Booking.new
    @num_tickets.to_i.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking was created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:flight_id, :num_passengers, passengers_attributes: [[:id, :name, :email]])
  end
end
