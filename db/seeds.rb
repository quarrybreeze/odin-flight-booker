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


Flight.find_or_create_by!(departure_airport: yyc, arrival_airport: yeg, start: DateTime.new(2025, 4, 5, 17, 0, 0), duration: 60*60)
Flight.find_or_create_by!(departure_airport: yeg, arrival_airport: yyc, start: DateTime.new(2025, 4, 5, 18, 30, 0), duration: 60*60)
Flight.find_or_create_by!(departure_airport: yyc, arrival_airport: yvr, start: DateTime.new(2025, 4, 6, 17, 30, 0), duration: 100*60)
Flight.find_or_create_by!(departure_airport: yvr, arrival_airport: yyc, start: DateTime.new(2025, 4, 7, 20, 00, 0), duration: 100*60)
Flight.find_or_create_by!(departure_airport: yyz, arrival_airport: yvr, start: DateTime.new(2025, 4, 8, 12, 30, 0), duration: 278*60)
Flight.find_or_create_by!(departure_airport: yvr, arrival_airport: yyz, start: DateTime.new(2025, 4, 9, 18, 00, 0), duration: 278*60)
