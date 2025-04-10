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

    respond_to do |format|
      if @booking.save
        @passengers = @booking.passengers
        @passengers.each do |passenger|
          PassengerMailer.with(passenger: passenger).confirmation_email.deliver_later
        end

        format.html { redirect_to booking_path(@booking), notice: "Booking was created successfully" }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:flight_id, :num_passengers, passengers_attributes: [[:id, :name, :email]])
  end
end