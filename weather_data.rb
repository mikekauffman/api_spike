require 'faraday'
require 'json'
require 'pp'
require 'date'

response = Faraday.get('http://api.openweathermap.org/data/2.5/weather?q=San$Francisco,CA&units=imperial')
city_data = JSON.parse(response.body)


forecast_response = Faraday.get('http://api.openweathermap.org/data/2.5/forecast/daily?q=San$Francisco,CA&units=imperial&cnt=7')
forecast_data = JSON.parse(forecast_response.body)

next_7_days_name = forecast_data["list"].map { |day| Date::DAYNAMES[(Date.jd(day["dt"])).wday] }

min_next_7 = forecast_data["list"].map { |day| day["temp"]["min"].to_i }
max_next_7 = forecast_data["list"].map { |day| day["temp"]["max"].to_i }
description_next_7 = forecast_data["list"].map { |day| day["weather"].first["main"].downcase }

x = 0
forecast = []
next_7_days_name.each do |name|
  forecast << "On #{name}, there will be a low of #{min_next_7[x]}, a high of #{max_next_7[x]} and the sky is #{description_next_7[x]}"
  x += 1
end

# DISPLAYED DATA BELOW

puts "The current temperature in San Francisco is #{city_data["main"]["temp"].to_i} degrees, and it's #{city_data["weather"].first["main"].downcase}"
puts "The 7-day forecast in San Francisco is:"
forecast.each {|day| puts day}