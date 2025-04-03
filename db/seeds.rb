# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
yyc = Airport.find_or_create_by!(iata: "YYC")
yeg = Airport.find_or_create_by!(iata: "YEG")
yyz = Airport.find_or_create_by!(iata: "YYZ")
yvr = Airport.find_or_create_by!(iata: "YVR")
yul = Airport.find_or_create_by!(iata: "YUL")

flights = [
  # YYC routes
  { departure: yyc, arrival: yeg, day: 1, hour: 7, min: 0, duration: 60 },
  { departure: yyc, arrival: yeg, day: 3, hour: 12, min: 30, duration: 60 },
  { departure: yyc, arrival: yyz, day: 5, hour: 15, min: 45, duration: 210 },
  { departure: yyc, arrival: yvr, day: 7, hour: 9, min: 15, duration: 100 },
  { departure: yyc, arrival: yul, day: 9, hour: 17, min: 0, duration: 240 },
  
  # YEG routes
  { departure: yeg, arrival: yyc, day: 2, hour: 8, min: 30, duration: 60 },
  { departure: yeg, arrival: yyz, day: 4, hour: 14, min: 0, duration: 240 },
  { departure: yeg, arrival: yvr, day: 6, hour: 11, min: 45, duration: 120 },
  { departure: yeg, arrival: yul, day: 8, hour: 16, min: 30, duration: 270 },
  
  # YYZ routes
  { departure: yyz, arrival: yyc, day: 10, hour: 13, min: 15, duration: 210 },
  { departure: yyz, arrival: yeg, day: 12, hour: 10, min: 0, duration: 240 },
  { departure: yyz, arrival: yvr, day: 14, hour: 18, min: 45, duration: 278 },
  { departure: yyz, arrival: yul, day: 16, hour: 7, min: 30, duration: 70 },
  
  # YVR routes
  { departure: yvr, arrival: yyc, day: 11, hour: 19, min: 0, duration: 100 },
  { departure: yvr, arrival: yeg, day: 13, hour: 6, min: 45, duration: 120 },
  { departure: yvr, arrival: yyz, day: 15, hour: 20, min: 30, duration: 278 },
  { departure: yvr, arrival: yul, day: 17, hour: 12, min: 15, duration: 290 },
  
  # YUL routes
  { departure: yul, arrival: yyc, day: 18, hour: 14, min: 45, duration: 240 },
  { departure: yul, arrival: yeg, day: 20, hour: 9, min: 30, duration: 270 },
  { departure: yul, arrival: yyz, day: 22, hour: 16, min: 0, duration: 70 },
  { departure: yul, arrival: yvr, day: 24, hour: 11, min: 45, duration: 290 }
]

200.times do |i|
  template = flights[i % flights.size]
  day_offset = (i / flights.size) * 2 # Spread flights every 2 days
  hour_variation = i % 4 # Add some hour variation
  
  day = template[:day] + day_offset
  day = day % 30 + 1 # Ensure day stays within April (1-30)
  
  hour = template[:hour] + hour_variation
  hour = hour % 24 # Ensure hour stays within 0-23
  
  Flight.find_or_create_by!(
    departure_airport: template[:departure],
    arrival_airport: template[:arrival],
    start: DateTime.new(2025, 4, day, hour, template[:min], 0),
    duration: template[:duration] * 60
  )
end
