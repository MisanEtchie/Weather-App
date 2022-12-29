//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 18/12/2022.
//

import SwiftUI

struct WeatherView: View {
    @Binding var weather: ResponseBody
    var image: String = "clear"
    let half = (UIScreen.main.bounds.width / (4/3))
    let point = (UIScreen.main.bounds.width / (4))
    var body: some View {
        VStack {
            HStack{
                Image(systemName: getIcon())
                //.font(.system(size: 30))
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.accentColor)
                    .frame(width: 35, height: 35).padding(6).background(Color(.white)).cornerRadius(30)
                VStack{
                    Text("Weather").foregroundColor(.white).bold().shadow(color: .black, radius: 5).frame(maxWidth: .infinity, alignment: .leading)
                    Text("What's the weather?").foregroundColor(.white).bold().shadow(color: .black, radius: 5)
                        .font(.caption).frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                
            }.padding().padding(.top)
                .padding(.bottom, 25)
            
            Text(weather.main.temp.roundDouble() + "°C").font(.system(size: 40.0)).foregroundColor(.white)
                .bold()
                .shadow(color: .black, radius: 5)
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal).padding(.bottom, 4)
            
            Text(weather.weather[0].description.capitalized).foregroundColor(.white).font(.system(size: 20.0))
                .bold()
                .shadow(color: .black, radius: 3).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal).padding(.bottom, point)
            
            Spacer()
        }// weather image box
        .frame(
            maxWidth: .infinity,
            maxHeight: half
        )
        .background(
            Image(getImage())
                .resizable()
                .scaledToFill()
        )
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    func getImage() -> String {
        if (weather.weather[0].main == "Thunderstorm") {
            return "storm"
        } else if (weather.weather[0].main == "Drizzle") {
            return  "rain"
        } else if (weather.weather[0].main == "Rain") {
            return "rain"
        } else if (weather.weather[0].main == "Snow") {
            return "snow"
        } else if (weather.weather[0].main == "Clear") {
            return "clear"
        } else if (weather.weather[0].main == "Clouds") {
            return "cloud"
        } else {
            return "fog"
        }
    }
    
    func getIcon() -> String {
        if (weather.weather[0].main == "Thunderstorm") {
            return "cloud.bolt.rain"
        } else if (weather.weather[0].main == "Drizzle") {
            return  "cloud.drizzle"
        } else if (weather.weather[0].main == "Rain") {
            return "cloud.rain"
        } else if (weather.weather[0].main == "Snow") {
            return "cloud.snow"
        } else if (weather.weather[0].main == "Clear") {
            return "sun.max"
        } else if (weather.weather[0].main == "Clouds") {
            return "cloud"
        } else {
            return "cloud.fog"
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    
    @State static var weather: ResponseBody = previewWeather
    
    static var previews: some View {
        WeatherView(weather: $weather)
    }
}
