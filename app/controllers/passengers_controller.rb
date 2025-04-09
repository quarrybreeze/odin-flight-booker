class PassengersController < ApplicationController

  def new
    
  end

  def destroy
    @passenger = Passenger.find(params[:id])
    @booking = @passenger.booking
    @passenger.destroy
    redirect_to @booking, notice: "Passenger was deleted"
  end

  private
  def passenger_params
    params.require(:passenger).permit(:name, :email)
  end

end
