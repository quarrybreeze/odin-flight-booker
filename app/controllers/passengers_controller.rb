class PassengersController < ApplicationController

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    @booking = @passenger.booking
    if @passenger.save
      redirect_to booking_path(@booking), notice: "Passenger was created successfully"
    else
      render booking_path(@booking), status: :unprocessable_entity
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
