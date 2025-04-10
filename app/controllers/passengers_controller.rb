class PassengersController < ApplicationController

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    @booking = @passenger.booking


    respond_to do |format|
      if @passenger.save
        PassengerMailer.with(passenger: @passenger).confirmation_email.deliver_later
        format.html { redirect_to booking_path(@booking), notice: "Booking was created successfully" }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @passenger = Passenger.find(params[:id])
    @booking = @passenger.booking
    @passenger.destroy
    redirect_to @booking, notice: "Passenger was deleted"
  end

  private
  def passenger_params
    params.require(:passenger).permit(:booking_id, :name, :email)
  end

end
