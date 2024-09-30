//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Misan Etchie on 18/12/2022.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject private var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            ContentView(weather: previewWeather, forecast: previewForecast)
                .environmentObject(settings)
        }
    }
}
