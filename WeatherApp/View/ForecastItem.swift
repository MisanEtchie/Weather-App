//
//  ForecastItem.swift
//  WeatherApp
//
//  Created by Misan on 9/12/24.
//

import SwiftUI

func convertDate(_ timestamp: TimeInterval, timezoneOffset: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timestamp + timezoneOffset)
    
    // Create a date formatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d"
    
    // Set the time zone to GMT 0 (Accra time)
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    // Format the date
    return dateFormatter.string(from: date)
}
//
//
//func formatTime(_ time: TimeInterval) -> String {
//    let date = Date(timeIntervalSince1970: time)
//    let dateFormatter = DateFormatter()
//    dateFormatter.timeStyle = .medium
//    return dateFormatter.string(from: date)
//}

func formatTimeHHmm(_ time: TimeInterval, timezoneOffset: TimeInterval) -> String {
    
    
    let date = Date(timeIntervalSince1970: time + timezoneOffset)
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss" // Format to HH:mm
    formatter.locale = Locale(identifier: "en_GB")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.string(from: date)
}



struct ForecastItem: View {
    var item: ForecastBody.WeatherEntry
    @Binding var weather: ResponseBody
    var unit: String
    
    
    var body: some View {
        
        let sunriseTime = formatTimeHHmm(TimeInterval(weather.sys.sunrise), timezoneOffset: TimeInterval(weather.timezone))
               let sunsetTime = formatTimeHHmm(TimeInterval(weather.sys.sunset), timezoneOffset: TimeInterval(weather.timezone))
               
               // Get the formatted forecast time
               let forecastTime = formatTimeHHmm(TimeInterval(item.dt), timezoneOffset: TimeInterval(weather.timezone))
        
        
        HStack {
            
            
            
            Image(systemName: getIcon(item: item, weather: weather))
            
            //.font(.system(size: 30))
            
                .resizable()
            
                .scaledToFit()
                .foregroundColor(Color("headerText"))
                .frame(width: 45, height: 45).padding(6).cornerRadius(30)//.background(Color(.white))
            
            VStack (alignment: .leading) {
                
                Text(convertTimestamp(TimeInterval(item.dt), timezoneOffset: TimeInterval(weather.timezone)) + " • " + convertDate(TimeInterval(item.dt), timezoneOffset: TimeInterval(weather.timezone)))
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Text(item.weather.first!.description.capitalized)
                    .bold()
                
                
                //.textCase(.)
            }
            
            Spacer()
            
            Text("\(item.main.temp.roundDouble())\(unit == "Metric" ? "°C" : "°F")")
            
            
            
            
            
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(Color("orange"))
            
        }
        .padding()
        .frame(
            maxWidth: .infinity
            //maxHeight: 100
        )
        .background(Color("reverseBg"))
        .cornerRadius(15).padding(.horizontal)
    }
    
    

    

    
    func getIcon(item: ForecastBody.WeatherEntry, weather: ResponseBody) -> String {
        
//        let sunriseTime = formatTimeHHmm(TimeInterval(weather.sys.sunrise), timezoneOffset: TimeInterval(weather.timezone))
//               let sunsetTime = formatTimeHHmm(TimeInterval(weather.sys.sunset), timezoneOffset: TimeInterval(weather.timezone))
//
//               // Get the formatted forecast time
//               let forecastTime = formatTimeHHmm(TimeInterval(item.dt), timezoneOffset: TimeInterval(weather.timezone))
        
        
        let sunriseTime = formatTimeHHmm(TimeInterval(weather.sys.sunrise), timezoneOffset: TimeInterval(weather.timezone))
        
        
        
               let sunsetTime = formatTimeHHmm(TimeInterval(weather.sys.sunset), timezoneOffset: TimeInterval(weather.timezone))
               
               // Get the formatted forecast time
               let forecastTime = formatTimeHHmm(TimeInterval(item.dt), timezoneOffset: TimeInterval(weather.timezone))
               
            
        let isDaytime = forecastTime >= sunriseTime && forecastTime <= sunsetTime
        
        // Adjust the logic to check if the current time is the same day as sunrise/sunset
        switch item.weather.first!.main {
            case "Clear":
                return isDaytime ? "sun.max" : "moon.stars"
            case "Clouds":
                return isDaytime ? "cloud.sun" : "cloud.moon"
            case "Thunderstorm":
                return "cloud.bolt.rain"
            case "Drizzle":
                return "cloud.drizzle"
            case "Rain":
                return "cloud.rain"
            case "Snow":
                return "cloud.snow"
            default:
                return "cloud.fog"
            }
    }
    
}



struct ForecastItem_Previews: PreviewProvider {
    @State static var forecast: ForecastBody = previewForecast
    @State static var weather: ResponseBody = previewWeather
    static var previews: some View {
        ForecastItem(item: forecast.list[0], weather: $weather, unit: "Metric")
    }
}
