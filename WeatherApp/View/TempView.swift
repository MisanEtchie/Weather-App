//
//  TempView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 19/12/2022.
//

import SwiftUI

struct TempView: View {
    @Binding var weather: ResponseBody
    var unit: String
    
    var body: some View {
        VStack {
            Text("Temperature").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal).padding(.top)
        
            
            HStack {
                
                HStack {
                    
                    Image(systemName: "thermometer")
                        .font(.system(size: 40).bold()).foregroundColor(.white).padding()
                    
                    VStack (alignment: .leading){
                        
                        Text("Min Temp").bold().foregroundColor(.white)
                        
                       
                        
                        Text("\(weather.main.tempMin.roundDouble())\(unit == "Metric" ? "°C" : "°F")" ).foregroundColor(.white).bold().frame(alignment: .trailing)//.padding()
                    }
                }
                
                HStack {
                    
                    Image(systemName: "thermometer")
                        .font(.system(size: 40).bold()).foregroundColor(.white).padding(.horizontal)
                    
                    VStack (alignment: .leading){
                        Text("Max Temp").bold().foregroundColor(.white)
                        
                        Text( "\(weather.main.tempMax.roundDouble())\(unit == "Metric" ? "°C" : "°F")" ).foregroundColor(.white).bold().frame(alignment: .trailing)//.padding()
                    }
                }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            
        }.padding(.vertical).frame(
            maxWidth: .infinity,
            maxHeight: 130
        )
        .background(Color("olive"))
        .cornerRadius(15).padding(.horizontal).padding(.top)
    }
}

struct TempView_Previews: PreviewProvider {
    @State static var weather: ResponseBody = previewWeather
    static var previews: some View {
        TempView(weather: $weather, unit: "Metric")
    }
}
