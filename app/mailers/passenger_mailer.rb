class PassengerMailer < ApplicationMailer
  default from: "bookings@airline.com"

  def confirmation_email
    @passenger = params[:passenger]
    mail(to: @passenger.email, subject: "Booking confirmed")
  end
end
