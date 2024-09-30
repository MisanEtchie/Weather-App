//
//  WeatherNowView.swift
//  WeatherApp
//
//  Created by Misan on 9/14/24.
//

import SwiftUI

struct WeatherNowView: View {
    @Binding var weather: ResponseBody
    var unit: String
    var image: String = "clear"
    let half = (UIScreen.main.bounds.width / (3/3))
    let point = (UIScreen.main.bounds.width / (4))
    var body: some View {
        VStack {
            
            Text("Weather right now...").foregroundColor(.white).font(.system(size: 20.0))
                .bold()
                //.shadow(color: .black, radius: 3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)
            
          
            
            
            HStack{
                Image(systemName: getIcon())
                //.font(.system(size: 30))
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50).padding(6)
                    //.background(Color(.white))
                    .cornerRadius(30)
                
                VStack (spacing: 0){
                    Text(
                         
                         "\(weather.main.temp.roundDouble())\(unit == "Metric" ? "°C" : "°F")"
                    
                    ).font(.system(size: 30.0)).foregroundColor(.white)
                        .bold()
                        //.shadow(color: .black, radius: 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(weather.weather[0].description.capitalized).foregroundColor(.white).font(.system(size: 20.0))
                        .bold()
                        //.shadow(color: .black, radius: 3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            
          
            
            
            
           
            
            
        }// weather image box
        .padding(.horizontal)
        .padding(.vertical, 30)
        .frame(
            maxWidth: .infinity
            //maxHeight: 170
        )
        .background(
            ZStack {
                Image(getImage())
                    .resizable()
                    .scaledToFill()
                
                LinearGradient(
                                   gradient: Gradient(colors: [Color("darkBlue"), Color.clear]),
                                   startPoint: .leading,
                                   endPoint: .trailing
                               )
            }
        )
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    func getImage() -> String {
        
        let sunriseTime = formatTimeHHmm(TimeInterval(weather.sys.sunrise), timezoneOffset: TimeInterval(weather.timezone))
               let sunsetTime = formatTimeHHmm(TimeInterval(weather.sys.sunset), timezoneOffset: TimeInterval(weather.timezone))
               
               // Get the formatted forecast time
        let forecastTime = formatTimeHHmm(Date().timeIntervalSince1970, timezoneOffset: TimeInterval(weather.timezone))
        
        let isDaytime = forecastTime >= sunriseTime && forecastTime <= sunsetTime
        
        
        if (weather.weather[0].main == "Thunderstorm") {
            return "storm"
        } else if (weather.weather[0].main == "Drizzle") {
            return  "rain"
        } else if (weather.weather[0].main == "Rain") {
            return "rain"
        } else if (weather.weather[0].main == "Snow") {
            return "snow"
        } else if (weather.weather[0].main == "Clear") {
            return isDaytime ? "clear" : "clearNight"
        } else if (weather.weather[0].main == "Clouds") {
            return isDaytime ? "cloud" : "cloudNight"
        } else {
            return "fog"
        }
    }
    
    func getIcon() -> String {
        let sunriseTime = formatTimeHHmm(TimeInterval(weather.sys.sunrise), timezoneOffset: TimeInterval(weather.timezone))
               let sunsetTime = formatTimeHHmm(TimeInterval(weather.sys.sunset), timezoneOffset: TimeInterval(weather.timezone))
               
               // Get the formatted forecast time
        let forecastTime = formatTimeHHmm(Date().timeIntervalSince1970, timezoneOffset: TimeInterval(weather.timezone))
        
        let isDaytime = forecastTime >= sunriseTime && forecastTime <= sunsetTime
        
        if (weather.weather[0].main == "Thunderstorm") {
            return "cloud.bolt.rain"
        } else if (weather.weather[0].main == "Drizzle") {
            return  "cloud.drizzle"
        } else if (weather.weather[0].main == "Rain") {
            return "cloud.rain"
        } else if (weather.weather[0].main == "Snow") {
            return "cloud.snow"
        } else if (weather.weather[0].main == "Clear") {
            return !isDaytime ? "moon.stars" : "sun.max"
        } else if (weather.weather[0].main == "Clouds") {
            return !isDaytime ? "cloud.moon" : "cloud.sun"
        } else {
            return "cloud.fog"
        }
    }
}

struct WeatherNowView_Previews: PreviewProvider {
    
    @State static var weather: ResponseBody = previewWeather
    
    static var previews: some View {
        WeatherNowView(weather: $weather, unit: "Metric")
    }
}
