//
//  WindView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 19/12/2022.
//

import SwiftUI

struct WindView: View {
    @Binding var weather: ResponseBody
    var unit: String
    
    func getWindSpeed (windSpeed: Double) -> String {
        
        let windS: Double
                if unit.lowercased() == "imperial" {
                    windS = windSpeed * 1.60934// Convert mph to km/h
                } else {
                    windS = windSpeed * 3.6// Assume it's already in km/h
                }
        
        if (windS <= 5) {
            return "Calm"
        } else if (windS <= 38) {
            return "Breeze"
        }
        else if (windS <= 49) {
            return "Strong Breeze"
        }
        else if (windS <= 74) {
            return "Gale"
        } else if (windS <= 107) {
            return "Storm"
        } else {
            return "Hurricane"
        }
    }
    
    var body: some View {
        
        
        
        VStack {
            
            HStack {
                Text("Wind Speed").foregroundColor(Color("darkBlue")).bold().frame(maxWidth: .infinity, alignment: .leading)
                
                Text(getWindSpeed(windSpeed: weather.wind.speed)).bold()
                    .foregroundColor(.white).padding(.horizontal).padding(.vertical, 4)
                .background(Color("orange"))
                .cornerRadius(10)//.padding(.horizontal)
                
            }.padding(.horizontal).padding(.top)
            
            Spacer()
            
            
            HStack{
                Image(systemName: "wind")
                    .font(.system(size: 30).bold()).foregroundColor(Color("darkBlue"))
                
                Text ("\(String(weather.wind.speed)) \(unit == "Metric" ? "m/s" : "mph")").foregroundColor(Color("darkBlue")).font(.system(size: 30.0)).bold()
                
                    Spacer()
            }.padding()
            
            
            
        }.frame(
            maxWidth: .infinity,
            maxHeight: 170
        )
        .background(Color("lightGray"))
        .cornerRadius(15).padding(.horizontal)
    }
}

struct WindView_Previews: PreviewProvider {
    @State static var weather: ResponseBody = previewWeather
    static var previews: some View {
        WindView(weather: $weather, unit: "Metric")
    }
}
