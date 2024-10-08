//
//  StatsView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 18/12/2022.
//

import SwiftUI

struct StatsView: View {
    @Binding var weather: ResponseBody
    var unit: String
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text("Pressure").foregroundColor(.white)
                        .font(.caption)
                    Text(String(weather.main.pressure) + "mb").font(.callout).bold().foregroundColor(.white)
                }.padding()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 70
                    )
                    .background(Color("darkBlue"))
                    .cornerRadius(15)//.padding(.leading, 4)
                
                VStack{
                    Text("Visibility").foregroundColor(.white)
                        .font(.caption)
                    
                    Text(String(weather.visibility / 1000) + "km").font(.callout).bold().foregroundColor(.white)
                }.padding()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 70
                    )
                    .background(Color("olive"))
                    .cornerRadius(15).padding(.leading, 4)
                
                VStack{
                    Text("Humidity").foregroundColor(Color("darkBlue"))
                        .font(.caption)
                    Text(String(weather.main.humidity) + "%").font(.callout).bold().foregroundColor(Color("darkBlue"))
                }.padding()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 70
                    )
                    .background(Color("lightGray"))
                    .cornerRadius(15).padding(.leading, 4)
                
            }.padding() // first Hstack
            
            
            WindView(weather: $weather, unit: unit)
            
            TempView(weather: $weather, unit: unit)
            
            
            SunView(weather: $weather)
            
            
                
                
                
            }
            
            
            
        } //main vstack
    }


struct StatsView_Previews: PreviewProvider {
    @State static var weather: ResponseBody = previewWeather
    
    static var previews: some View {
        StatsView(weather: $weather, unit: "Metric")
    }
}
