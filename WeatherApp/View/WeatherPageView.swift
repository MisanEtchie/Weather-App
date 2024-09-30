//
//  WeatherPageView.swift
//  WeatherApp
//
//  Created by Misan on 9/12/24.
//

import SwiftUI

struct WeatherPageView: View {
    @Binding var weather: ResponseBody
    var unit: String
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .firstTextBaseline, spacing: 0){
                    Text(weather.name).font(.largeTitle).foregroundColor(Color("headerText"))
                        .bold()
                    
                    Text(", " + weather.sys.country).font(.title3).foregroundColor(Color("headerText"))
                        .bold()
                }
                
                Text("Today, \(Date().formatted(.dateTime.day().month().hour().minute()))").font(.footnote).foregroundColor(Color("headerText"))
                
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            //location header
            
            
            
            WeatherView(weather: $weather, unit: unit)
            
            StatsView(weather: $weather, unit: unit)
            
            .padding(.bottom, 50)
        }
    }
}

struct WeatherPageView_Previews: PreviewProvider{
    @State static var weather: ResponseBody = previewWeather
    static var previews: some View {
        WeatherPageView(weather: $weather, unit: "Metric")
    }
}

