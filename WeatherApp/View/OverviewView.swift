//
//  OverviewView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 26/07/2024.
//

import SwiftUI
import CoreLocation

struct OverviewView: View {
    @Binding var weather: ResponseBody
    var body: some View {
        ScrollView(showsIndicators: false){
            
            Spacer()
                .frame(height: 20)
            
            WeatherView(weather: $weather)
            
            StatsView(weather: $weather)
            
            Spacer()
                .frame(height: 50)
        }
        
        
    }
}

struct OverviewView_Previews: PreviewProvider {
    
    @State static var weather: ResponseBody = previewWeather
    
    static var previews: some View {
        OverviewView(weather: $weather)
    }
}
